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
# One (and only one) of the following variables must ="true"
VM_CPU="false" # true if installing in VM guest
AMD_CPU="false"
INTEL_CPU="false"

# GPU Configuration
# If VM_CPU="true" AMD_GPU && INTEL_GPU && NIVIDIA_GPU variables must ="false"
AMD_GPU="false"
INTEL_GPU="false"
NVIDIA_GPU="false"

# Network Configuration
# Use "ip link show" to view all network interfaces.
# Wireless interfaces typically begin with "wl" e.g. "wlp0s20f3".
WIFI_INTERFACE="" # leave blank if using ethernet or if VM_CPU="true"
WIFI_ESSID=""
WIFI_KEY=""
WIFI_HIDDEN=""
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

# Installation Scripts
#################################################

function main() {
    
    check_variables
    check_critical_prereqs
    check_configure_network

    loadkeys ${KEYS}

    confirm_install
    install
}

function install() {

    # Update system clock
    timedatectl set-ntp true

    # Partion the drive with a single 512 MB ESP partition, and the rest of the drive as the root partition
    parted -s ${HD_DEVICE} mklabel gpt mkpart ESP fat32 1MiB 512MiB mkpart root ext4 512MiB 100% set 1 esp on

    # Format the partitions, ESP as fat32, root as ext4
    mkfs.fat -n ESP -F32 ${HD_DEVICE}1
    mkfs.ext4 -L root ${HD_DEVICE}2

    # Mount root partition
    mount -o defaults,noatime ${HD_DEVICE}2 /mnt

    # Mount the ESP partition
    mkdir /mnt/boot
    mount -o defaults,noatime ${HD_DEVICE}1 /mnt/boot

    # Create the swapfile
    dd if=/dev/zero of=/mnt/swapfile bs=1M count=${SWAPSIZE} status=progress
    chmod 600 /mnt/swapfile
    mkswap /mnt/swapfile

    # Install essential packages via pacstrap
    if [[ "$VM_CPU" == "true" ]]; then
        # When installing in VM, do not install linux-firmware
        pacstrap /mnt base base-devel linux-zen linux-zen-headers xdg-user-dirs man-db man-pages texinfo dosfstools exfatprogs e2fsprogs neovim networkmanager git
    else
        pacstrap /mnt base base-devel linux-zen linux-zen-headers linux-firmware xdg-user-dirs man-db man-pages texinfo dosfstools exfatprogs e2fsprogs neovim networkmanager git
    fi
    
    # Enable NetworkManager.service
    # Note: NetworkManager will handle DHCP
    arch-chroot /mnt systemctl enable NetworkManager.service

    # Configure color support for pacman
    sed -i 's/#Color/Color/' /mnt/etc/pacman.conf
    sed -i 's/#TotalDownload/TotalDownload/' /mnt/etc/pacman.conf

    # Generate fstab
    genfstab -U /mnt >> /mnt/etc/fstab
    echo "# swap" >> /mnt/etc/fstab
    echo "/swapfile none swap defaults 0 0" >> /mnt/etc/fstab
    echo "" >> /mnt/etc/fstab

    # Configure swappiness paramater (default=60) to improve system responsiveness
    echo "vm.swappiness=10" > /mnt/etc/sysctl.d/99-sysctl.conf

    # Enable periodic trim if the HD supports TRIM
    if [[ "$TRIM_SUPPORT" == "true" ]]; then
        arch-chroot /mnt systemctl enable fstrim.timer
    fi

    # Configure timezone and system clock
    arch-chroot /mnt ln -s -f ${TIMEZONE} /etc/localtime
    arch-chroot /mnt hwclock --systohc

    # Configure locale
    arch-chroot /mnt sed -i "s/#${LOCALE}/${LOCALE}/" /mnt/etc/locale.gen
    arch-chroot /mnt locale-gen
    echo -e "LANG=${LANG}" >> /mnt/etc/locale.conf

    # Configure hostname and hosts files
    echo ${HOSTNAME} > /mnt/etc/hostname
    echo "127.0.0.1	localhost" >> /mnt/etc/hosts
    echo "::1 localhost" >> /mnt/etc/hosts
    echo "127.0.0.1	${HOSTMAME}.localdomain ${HOSTNAME}" >> /mnt/etc/hosts

    # Configure root password
    printf "${ROOT_PASSWORD}\n${ROOT_PASSWORD}" | arch-chroot /mnt passwd

    # Install and configure Grub as bootloader on ESP
    arch-chroot /mnt pacman -Syu --noconfirm --needed grub efibootmgr
    arch-chroot /mnt grub-install --target=x86_64-efi --bootloader-id=grub --efi-directory=/boot --recheck
    arch-chroot /mnt grub-mkconfig -o /boot/grub/grub.cfg

    # Setup user and allow user to use "sudo"
    arch-chroot /mnt useradd -m -G wheel,storage,optical -s /bin/bash ${USER_NAME}
    printf "${USER_PASSWORD}\n${USER_PASSWORD}" | arch-chroot /mnt passwd ${USER_NAME}
    arch-chroot /mnt sed -i 's/# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/' /etc/sudoers

    # Install Gnome
    arch-chroot /mnt pacman -Syu --noconfirm --needed gnome gnome-extra
    arch-chroot /mnt systemctl enable gdm.servic
}

function check_variables() {
    check_variables_value "HD_DEVICE" "$HD_DEVICE"
    check_variables_value "SWAPSIZE" "$SWAPSIZE"
    check_variables_boolean "TRIM_SUPPORT" "$TRIM_SUPPORT"
    check_variables_boolean "VM_CPU" "$VM_CPU"
    check_variables_boolean "AMD_CPU" "$AMD_CPU"
    check_variables_boolean "INTEL_CPU" "$INTEL_CPU"
    check_variables_boolean "AMD_GPU" "$AMD_GPU"
    check_variables_boolean "INTEL_GPU" "$INTEL_GPU"
    check_variables_boolean "NVIDIA_GPU" "$NVIDIA_GPU"

    if [ -n "$WIFI_INTERFACE" ]; then
        check_variables_value "WIFI_ESSID" "$WIFI_ESSID"
    fi

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

function check_variables_value() {
    NAME=$1
    VALUE=$2
    if [[ -z "$VALUE" ]]; then
        echo "Error: $NAME must have a value."
        exit
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
            echo "Error: $NAME must be {true|false}."
            exit
            ;;
    esac
}

function check_critical_prereqs() {
    if [[ ! -d /sys/firmware/efi ]]; then
        echo "Error: soagi can only be run on UEFI systems."
        exit
    fi

    if [[ "$VM_CPU" == "false" && "$AMD_CPU" == "false" && "$INTEL_CPU" == "false" ]]; then
        echo "Error: One of the following variables {VM_CPU|AMD_CPU|INTEL_CPU} must be =true."
        exit
    fi

    if [[ "$VM_CPU" == "true" ]]; then
        if [[ "$AMD_CPU" == "true" || "$INTEL_CPU" == "true" || "$AMD_GPU" == "true" || "$INTEL_GPU" == "true" || "$NVIDIA_GPU" == "true" ]]; then
            echo "Error: If VM_CPU=true then AMD_CPU && INTEL_CPU && AMD_GPU && INTEL_GPU && NVIDIA_GPU must =false."
            exit
        fi
        if [[ -n "$WIFI_INTERFACE" ]]; then
            echo "Error: If VM_CPU=true then WIFI_INTERFACE cannot have a value."
            exit
        fi
    fi

    if [[ "$AMD_CPU" == "true" && "$INTEL_CPU" == "true" ]]; then
        echo "Error: AMD_CPU and INTEL_CPU are mutually exclusve and can't both =true."
        exit
    fi
}

function check_configure_network() {
    if [ -n "$WIFI_INTERFACE" ]; then
        cp /etc/netctl/examples/wireless-wpa /etc/netctl
        chmod 600 /etc/netctl/wireless-wpa

        sed -i 's/^Interface=.*/Interface='"${WIFI_INTERFACE}"'/' /etc/netctl/wireless-wpa
        sed -i 's/^ESSID=.*/ESSID='"${WIFI_ESSID}"'/' /etc/netctl/wireless-wpa
        sed -i 's/^Key=.*/Key=\"'"${WIFI_KEY}"'\"/' /etc/netctl/wireless-wpa
        if [ "$WIFI_HIDDEN" == "true" ]; then
            sed -i 's/^#Hidden=.*/Hidden=yes/' /etc/netctl/wireless-wpa
        fi

        netctl stop-all
        netctl start wireless-wpa
        sleep 10
    fi

    ping -c 1 -i 2 -W 5 -w 30 ${PING_HOSTNAME}
    if [ $? -ne 0 ]; then
        echo "Error: Network ping check failed. Cannot continue."
        exit
    fi
}

function confirm_install() {
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

main $@