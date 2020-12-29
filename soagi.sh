#!/bin/bash
# Simple Opinionated Arch Gnome Installer

# Configuration
#################################################

# HD Configuration
# Run "lsblk" to determine HD device name
# To check for TRIM support, run "lsblk --discard". If DISC-GRAN && DISC-MAX are > 0, your HD supports TRIM.
# If running as VM, you'll need to double check if TRIM is supported.  Newer KVM/Qemu VMs should support TRIM.
HD_DEVICE="" # /dev/sda /dev/nvme0n1 /dev/vda
TRIM_SUPPORT="true" # typically set to true if HD is an SSD, see notes above
SWAPSIZE="2048" # 4096 8912

# CPU Configuration
# Note: if installing in a VM leave both set to 'false'
AMD_CPU="false"
INTEL_CPU="false"

# GPU Configuration
AMD_GPU="false"
INTEL_GPU="false"
NVIDIA_GPU="false"

# Install Xorg and configure Gnome to use it by default?
XORG_INSTALL="true" #false

# Hostname to ping to check network connection
PING_HOSTNAME="www.google.com"

# Hostname Configuration
HOSTNAME="soagi"

# Locale Configuration
# To list out all timezones in US run "ls -l /usr/share/zoneinfo/America"
KEYS="us"
TIMEZONE="/usr/share/zoneinfo/America/Denver"
LOCALE="en_US.UTF-8 UTF-8"
LANG="en_US.UTF-8"

# User Configuration
ROOT_PASSWORD=""
USER_NAME=""
USER_PASSWORD=""

# Additional Linux Command Line Params
CMDLINE_LINUX=""

# Installation Scripts
#################################################

function main() {
    
    check_critical_prereqs
    check_variables
    check_conflicts
    check_network

    loadkeys $KEYS

    confirm_install
    install
}

function install() {

    # Update system clock
    timedatectl set-ntp true

    # Partion the drive with a single 512 MB ESP partition, and the rest of the drive as the root partition
    parted -s $HD_DEVICE mklabel gpt mkpart ESP fat32 1MiB 512MiB mkpart root ext4 512MiB 100% set 1 esp on

    # Is the the hard drive an NVME SSD?
    if [[ -n "$(echo $HD_DEVICE | grep "^/dev/nvme")" ]]; then
        BOOT_PARTITION="${HD_DEVICE}p1"
        ROOTFS_PARTITION="${HD_DEVICE}p2"
    else
        BOOT_PARTITION="${HD_DEVICE}1"
        ROOTFS_PARTITION="${HD_DEVICE}2"
    fi

    # Create the filesystem for the ESP partition
    mkfs.fat -n ESP -F32 $BOOT_PARTITION

    # Create the filesystem for the root partition
    yes | mkfs.ext4 -L ROOT $ROOTFS_PARTITION

    # Mount the root partition
    mount -o defaults,noatime $ROOTFS_PARTITION /mnt

    # Create directory to support mounting ESP
    mkdir /mnt/boot

    # Mount the ESP partition
    mount -o defaults,noatime $BOOT_PARTITION /mnt/boot

    SWAPFILE="/swapfile"
    fallocate --length ${SWAPSIZE}MiB /mnt"$SWAPFILE"
    chown root /mnt"$SWAPFILE"
    chmod 600 /mnt"$SWAPFILE"
    mkswap /mnt"$SWAPFILE"

    # Install essential packages via pacstrap
    ESSENTIAL_PACKAGES="base base-devel linux-zen linux-zen-headers fwupd xdg-user-dirs man-db man-pages texinfo dosfstools exfatprogs e2fsprogs networkmanager git vim"
    pacstrap /mnt $ESSENTIAL_PACKAGES

    # Install additional firmware and uCode
    if [[ "$AMD_CPU" == "true" ]]; then
        arch-chroot /mnt pacman -Syu --noconfirm --needed linux-firmware amd-ucode

    elif [[ "$INTEL_CPU" == "true" ]]; then
        arch-chroot /mnt pacman -Syu --noconfirm --needed linux-firmware intel-ucode
    fi

    # Enable NetworkManager.service
    # Note: NetworkManager will handle DHCP
    arch-chroot /mnt systemctl enable NetworkManager.service

    # Enable bluetooth.service
    arch-chroot /mnt systemctl enable bluetooth.service

    # Configure color support for pacman
    arch-chroot /mnt sed -i 's/#Color/Color/' /etc/pacman.conf
    arch-chroot /mnt sed -i 's/#TotalDownload/TotalDownload/' /etc/pacman.conf

    # Enable multilib
    arch-chroot /mnt sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf
    arch-chroot /mnt pacman -Syyu

    # Generate initial fstab using UUIDs
    genfstab -U /mnt > /mnt/etc/fstab

    # Create a dedicated entry for swapfile
    echo "# swapfile" >> /mnt/etc/fstab
    echo "$SWAPFILE none swap defaults 0 0" >> /mnt/etc/fstab
    echo "" >> /mnt/etc/fstab

    # Configure swappiness paramater (default=60) to improve system responsiveness
    echo "vm.swappiness=10" > /mnt/etc/sysctl.d/99-sysctl.conf

    # Enable periodic trim if the HD supports TRIM
    if [[ "$TRIM_SUPPORT" == "true" ]]; then
        arch-chroot /mnt systemctl enable fstrim.timer
    fi

    # Configure timezone and system clock
    arch-chroot /mnt ln -s -f $TIMEZONE /etc/localtime
    arch-chroot /mnt hwclock --systohc

    # Configure locale
    arch-chroot /mnt sed -i "s/#$LOCALE/$LOCALE/" /etc/locale.gen
    arch-chroot /mnt locale-gen
    echo -e "LANG=$LANG" >> /mnt/etc/locale.conf

    # Configure hostname and hosts files
    echo $HOSTNAME > /mnt/etc/hostname
    echo "127.0.0.1	localhost" >> /mnt/etc/hosts
    echo "::1 localhost" >> /mnt/etc/hosts
    echo "127.0.0.1	${HOSTMAME}.localdomain $HOSTNAME" >> /mnt/etc/hosts

    # Configure root password
    printf "$ROOT_PASSWORD\n$ROOT_PASSWORD" | arch-chroot /mnt passwd

    arch-chroot /mnt sed -i 's/GRUB_CMDLINE_LINUX=""/GRUB_CMDLINE_LINUX="'"$CMDLINE_LINUX"'"/' /etc/default/grub

    # Install and configure Grub as bootloader on ESP
    arch-chroot /mnt pacman -Syu --noconfirm --needed grub efibootmgr

    # Note the '--removable' switch will also setup grub on /boot/EFI/BOOT/BOOTX64.EFI (which is the Windows default location)
    # This is neccessary because many BIOSes don't honor efivars correctly
    arch-chroot /mnt grub-install --target=x86_64-efi --bootloader-id=grub --efi-directory=/boot --recheck --removable
    arch-chroot /mnt grub-mkconfig -o /boot/grub/grub.cfg

    # Setup user and allow user to use "sudo"
    arch-chroot /mnt useradd -m -G wheel,storage,optical -s /bin/bash $USER_NAME
    printf "$USER_PASSWORD\n$USER_PASSWORD" | arch-chroot /mnt passwd $USER_NAME
    arch-chroot /mnt sed -i 's/# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/' /etc/sudoers

    # Install Gnome
    COMMON_GNOME_PACKAGES="gnome gnome-tweaks noto-fonts noto-fonts-emoji"

    if [[ "$XORG_INSTALL" == "true" ]]; then
        arch-chroot /mnt pacman -Syu --noconfirm --needed $COMMON_GNOME_PACKAGES xorg-server
        arch-chroot /mnt sed -i "s/#WaylandEnable=false/WaylandEnable=false/" /etc/gdm/custom.conf
    else
        arch-chroot /mnt pacman -Syu --noconfirm --needed $COMMON_GNOME_PACKAGES
    fi

    arch-chroot /mnt systemctl enable gdm.service

    # Hack to work around GDM startup race condition (bug). Add small delay when starting up GDM	
    # https://bugs.archlinux.org/task/63763	
    arch-chroot /mnt sed -i '/^\[Service\]/a ExecStartPre=\/bin\/sleep 2' /usr/lib/systemd/system/gdm.service	

    # Also configure a pacman hook for GDM to reapply the fix if gdm package is ever updated	
    configure_pacman_gdm_hook

    # Install GPU Drivers
    COMMON_VULKAN_PACKAGES="vulkan-icd-loader lib32-vulkan-icd-loader vulkan-tools"

    if [[ "$INTEL_GPU" == "true" ]]; then
        # Note: installing newer intel-media-driver (iHD) instead of libva-intel-driver (i965)
        arch-chroot /mnt pacman -Syu --noconfirm --needed $COMMON_VULKAN_PACKAGES mesa lib32-mesa vulkan-intel lib32-vulkan-intel intel-media-driver libva-utils
    fi

    if [[ "$AMD_GPU" == "true" ]]; then
        arch-chroot /mnt pacman -Syu --noconfirm --needed $COMMON_VULKAN_PACKAGES mesa lib32-mesa vulkan-radeon lib32-vulkan-radeon libva-mesa-driver libva-utils
    fi
    
    if [[ "$NVIDIA_GPU" == "true" ]]; then
        arch-chroot /mnt pacman -Syu --noconfirm --needed $COMMON_VULKAN_PACKAGES nvidia-dkms nvidia-utils lib32-nvidia-utils nvidia-settings

        # Configure pacman to rebuild the initramfs each time the nvidia package is updated
        configure_pacman_nvidia_hook
    fi

    # Clone soagi git repo so that user can run post-install recipe
    arch-chroot /mnt git clone https://github.com/rstrube/soagi /home/${USER_NAME}/soagi
    arch-chroot /mnt chown -R ${USER_NAME}:${USER_NAME} /home/${USER_NAME}/soagi
    
    echo -e "${LIGHT_BLUE}Installation has completed! Run 'reboot' to reboot your machine.${NC}"
}

function check_critical_prereqs() {

    check_variables_value "HD_DEVICE" "$HD_DEVICE"
    
    if [[ ! -e "$HD_DEVICE" ]]; then
        echo -e "${RED}Error: HD_DEVICE="$HD_DEVICE" does not exist.${NC}"
        exit 1
    fi

    if [[ ! -d /sys/firmware/efi ]]; then
        echo -e "${RED}Error: soagi can only be run on UEFI systems.${NC}"
        echo "If running in a VM, make sure the VM is configured to use UEFI instead of BIOS."
        exit 1
    fi
}

function check_variables() {

    check_variables_value "HD_DEVICE" "$HD_DEVICE"
    check_variables_value "SWAPSIZE" "$SWAPSIZE"
    check_variables_boolean "TRIM_SUPPORT" "$TRIM_SUPPORT"
    check_variables_boolean "AMD_CPU" "$AMD_CPU"
    check_variables_boolean "INTEL_CPU" "$INTEL_CPU"
    check_variables_boolean "AMD_GPU" "$AMD_GPU"
    check_variables_boolean "INTEL_GPU" "$INTEL_GPU"
    check_variables_boolean "NVIDIA_GPU" "$NVIDIA_GPU"
    check_variables_boolean "XORG_INSTALL" "$XORG_INSTALL"
    check_variables_value "PING_HOSTNAME" "$PING_HOSTNAME"
    check_variables_value "HOSTNAME" "$HOSTNAME"
    check_variables_value "TIMEZONE" "$TIMEZONE"
    check_variables_value "KEYS" "$KEYS"
    check_variables_value "LOCALE" "$LOCALE"
    check_variables_value "LANG" "$LANG"
    check_variables_value "ROOT_PASSWORD" "$ROOT_PASSWORD"
    check_variables_value "USER_NAME" "$USER_NAME"
    check_variables_value "USER_PASSWORD" "$USER_PASSWORD"
}

ERROR_VARS_MESSAGE="${RED}Error: you must edit soagi.sh (e.g. with vim) and configure the required variables.${NC}"

function check_variables_value() {

    NAME=$1
    VALUE=$2
    if [[ -z "$VALUE" ]]; then
        echo -e $ERROR_VARS_MESSAGE
        echo "$NAME must have a value."
        exit 1
    fi
}

function check_variables_boolean() {

    NAME=$1
    VALUE=$2
    case $VALUE in
        true )
            ;;
        false )
            ;;
        * )
            echo -e $ERROR_VARS_MESSAGE
            echo "$NAME must be {true|false}."
            exit 1
            ;;
    esac
}

function check_conflicts() {

    if [[ "$AMD_CPU" == "true" && "$INTEL_CPU" == "true" ]]; then
        echo -e "${RED}Error: AMD_CPU and INTEL_CPU are mutually exclusve and can't both =true.${NC}"
        exit 1
    fi
}

function check_network() {

    ping -c 1 -i 2 -W 5 -w 30 $PING_HOSTNAME
    
    if [ $? -ne 0 ]; then
        echo "Error: Network ping check failed. Cannot continue."
        exit 1
    fi
}

function confirm_install() {

    clear

    echo -e "${LIGHT_BLUE}soagi (Simple Opinionated Arch Gnome Installer)${NC}"
    echo ""
    echo -e "${RED}Warning"'!'"${NC}"
    echo -e "${RED}This script will destroy all data on ${HD_DEVICE}${NC}"
    echo ""
    read -p "Do you want to continue? [y/N] " yn
    case $yn in
        [Yy]* )
            ;;
        [Nn]* )
            exit
            ;;
        * )
            exit
            ;;
    esac
}

function configure_pacman_gdm_hook() {	

    if [[ ! -d "/mnt/etc/pacman.d/hooks" ]]; then	
        mkdir -p /mnt/etc/pacman.d/hooks	
    fi	

    cat <<EOT > "/mnt/etc/pacman.d/hooks/gdm.hook"	
[Trigger]                            	
Operation=Install	
Operation=Upgrade	
Type=Package	
Target=gdm	
[Action]	
Description=Adds a small delay to /usr/lib/systemd/system/gdm.service to work around bug	
Depends=coreutils	
When=PostTransaction	
Exec=/usr/bin/sed -i '/^\[Service\]/a ExecStartPre=\/bin\/sleep 2' /usr/lib/systemd/system/gdm.service	
EOT	

}

function configure_pacman_nvidia_hook() {

    if [[ ! -d "/mnt/etc/pacman.d/hooks" ]]; then
        mkdir -p /mnt/etc/pacman.d/hooks
    fi

    cat <<EOT > "/mnt/etc/pacman.d/hooks/nvidia.hook"
[Trigger]
Operation=Install
Operation=Upgrade
Operation=Remove
Type=Package
Target=nvidia

[Action]
Description=Update Nvidia module in initcpio
Depends=mkinitcpio
When=PostTransaction
Exec=/usr/bin/mkinitcpio -P
EOT

}

# Console Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
LIGHT_BLUE='\033[1;34m'
NC='\033[0m'

main "$@"
