# sagi (Simple Arch Gnome Installer)
Sagi is a concise, easy to follow installation script for Arch linux which results in a minimal Arch "vanilla" Gnome installation.

To install you boot off of the Arch Linux ISO (like a manual Arch Linux install).  Once you've booted up your system, configure your network and download the main installation shell script.

![Editing sagi.sh](https://github.com/rstrube/sagi/blob/main/doc/img/download-sh.png)

Edit the installation script and define your configuration parameters (more details below).

![Editing sagi.sh](https://github.com/rstrube/sagi/blob/main/doc/img/editing-sh.png)

Sagi will give you a final confirmation summarizing your parameters.

![Confirmation](https://github.com/rstrube/sagi/blob/main/doc/img/confirmation.png)

Installation should take around 5 minutes and you'll end up with an almost completely vanilla / stock Gnome installation.

![Base Sagi Installation Result](https://github.com/rstrube/sagi/blob/main/doc/img/base-install.png)

## Inspiration
Sagi was heavily inspired by [alis (Arch Linx Install Script)](https://github.com/picodotdev/alis).  alis is extremely customizable and offers a wide variety of installation options, filesystems, partitioning schemes, packages, DEs' etc. but for many people that just want to get up and running on Arch quickly it can provide *too many* options.

## Goals
Sagi has the following goals:
1. Be easy to follow and learn from
1. Follow the installation approach outlined in the Arch Linux wiki
1. Provide minimal configuration options
1. Provide sane (albeit opinionated) defaults for a minimal Arch "vanilla" Gnome installation
1. Provide optional post-installation capabalities 

### Easy to Follow, Easy to Learn From
The main [sagi.sh](https://github.com/rstrube/sagi/blob/main/sagi.sh) installation script was designed to very easy to follow and understand.  The script itself it not very long, and has comments for each and every action that takes place.

### Follows Arch Wiki Installation
Each and every action in the installation script *directly* correlates to actions that are described in the [Arch Wiki Installation Guide](https://wiki.archlinux.org/index.php/Installation_guide).  The goal here is to provide a learning opportunity for new Arch users, and to not do anything out of the ordinary.

### Miminal Configuration Options
The configuration options can be defined in seconds.  Define some hardware details (HD, CPU, GPU(s)), locale info, user information and password, etc. and you're done!

Here is the configuration section from the installation script:

```
# Configuration
#################################################

# HD Configuration
# Run "lsblk" to determine HD device name
# To check for TRIM support, run "lsblk --discard". If DISC-GRAN && DISC-MAX are > 0, your HD supports TRIM.
# If running as VM, you'll need to double check if TRIM is supported.  Newer KVM/Qemu VMs should support TRIM.
HD_DEVICE="" # /dev/sda /dev/nvme0n1 /dev/vda
TRIM_SUPPORT="true" # typically set to true if HD is an SSD, see notes above
SWAPFILE_SIZE="2048" # 4096 8912 (in MiB)

# CPU Configuration
# Note: if installing in a VM leave both set to 'false'
AMD_CPU="false"
INTEL_CPU="false"

# GPU Configuration
AMD_GPU="false"
INTEL_GPU="false"
NVIDIA_GPU="false"

# Install Xorg and configure Gnome to use it by default?
# If set to "false" Gnome will be configured to use Wayland by default
XORG_INSTALL="false"

# Hostname to ping to check network connection
PING_HOSTNAME="www.google.com"

# Hostname Configuration
HOSTNAME="sagi"

# Locale Configuration
# To list out all timezones in US run "ls -l /usr/share/zoneinfo/America"
KEYS="us"
TIMEZONE="/usr/share/zoneinfo/America/Denver"
LOCALE="en_US.UTF-8 UTF-8"
LANG="en_US.UTF-8"
REFLECTOR_COUNTRY="United States"

# User Configuration
ROOT_PASSWORD=""
USER_NAME=""
USER_PASSWORD=""

# Additional Linux Command Line Params
CMDLINE_LINUX=""
```
### Sane Defaults
Sagi installs a "sane" set of packages with the *base* system.  As such the core set of packages that are installed doesn't vary much based on your configuration options (the exception being driver related packages).

The list below represents (at a high level) the base system Sagi creates for you:
* UEFI systems only
* Grub bootloader
* Latest Linux kernel
* ext4 filesystem
* Swapfile
* Latest CPU uCode (AMD or Intel)
* Mesa/Vulkan support for Intel/AMD GPUs
* Nvidia proprietary driver/Vulkan support for Nvidia GPUs
* Gnome
* NetworkManager
* Pipewire

Below is a more detailed list of the exact packages/virtual packages that are installed:

*Note: some of the packages (e.g. `base, base-devel` etc.) are virtual packages that bundle together many individual packages. There are also packages that are installed because they are dependencies. In total you can expect **~730-750** total packages to be installed as part of the base installation.*

**Always Installed:**
```
base base-devel linux linux-headers fwupd xdg-user-dirs man-db man-pages texinfo dosfstools exfatprogs e2fsprogs networkmanager git vim grub efibootmgr gnome gnome-tweaks noto-fonts noto-fonts-emoji pipewire pipewire-pulse
```

**Xorg installs:**
```
xorg-server
```

**Wayland installs:**
```
xorg-xlsclients xdg-desktop-portal-gtk wl-clipboard
```

**Systems with AMD CPUs:**
```
linux-firmware amd-ucode
```

**Systems with Intel CPUs:**
```
linux-firmware intel-ucode
```

**Vulkan:**
```
vulkan-icd-loader lib32-vulkan-icd-loader vulkan-tools
```

**Systems with Intel GPUs:**
```
mesa lib32-mesa vulkan-intel lib32-vulkan-intel intel-media-driver libva-utils
```

**Systems with AMD GPUs:**
```
mesa lib32-mesa vulkan-radeon lib32-vulkan-radeon libva-mesa-driver libva-utils
```

**Systems with Nvidia GPUs:**
```
nvidia-dkms nvidia-utils lib32-nvidia-utils nvidia-settings
```

### Post-Installation Capabilities
*Still need some time to document these.*

## Base Installation Procedure
The base installation process is quite simple:

1. Boot off of the [Arch installation ISO](https://www.archlinux.org/download/)
2. Run `iwctl` to connect to WiFi (see below)

*Note: ethernet connections should be setup automatically*

3. Run `lsblk` and note your HD device name

*Note: common HD device names are:*
* SATA HDs are usually something like: `/dev/sdx` (e.g. `/dev/sda`)
* NVME HDs are usually something like: `/dev/nvme0n1`
* KVM/Qemu VM HDs are usually: `/dev/vda`

4. Download the main sogai installation script:
```
curl -O https://raw.githubusercontent.com/rstrube/sagi/main/sagi.sh
```
5. Edit the installation script and define your configuration parameters:

```
vim sgai.sh
```
6. Change permissions on script to make it executable:
```
chmod +x sagi.sh
```
7. Execute script:
```
./sagi.sh
```
On most modern systems the installation takes around 5 minutes.

### Using iwctl to Connect to WiFi for Installation
The Arch Linux Installation ISO comes with `iwctl` which can be used to easily connect to WiFi networks.

After booting up enter the following commands:

1. `iwctl device list` to identify your WiFi device (e.g. `wlp0s20f3`).  Use in place of `{DEVICE}` for the following commands:
1. `iwctl station {DEVICE} scan`
1. `iwctl station {DEVICE} get-networks` should get you a list of SSIDs.  Use your SSID in place of `{SSID}` for the following command:
1. `iwctl station {DEVICE} connect {SSID}` should prompt you to enter in your password to connect to specified network.

Note: Sagi does **not** install `iwctl`, instead NetworkManager is installed, including `nmcli` for command line operations, and `nmtui` for a terminal based graphical way to configure your network settings. `iwctl` should *only* be used for installation and is recommended because it comes by default with the Arch Linux Installation ISO.
