# soagi (Simple Opinionated Arch Gnome Installer)
Soagi is a concise, easy to follow installation script for Arch linux which results in a minimal Arch "vanilla" Gnome installation.

## Inspiration
Soagi was heavily inspired by [alis (Arch Linx Install Script)](https://github.com/picodotdev/alis).  alis is extremely customizable and offers a wide variety of installation options, filesystems, partitioning schemes, packages, DEs' etc. but for many people that just want to get up and running on Arch quickly it can provide *too many* options.

## Goals
Soagi has the following goals:
1. Be easy to follow and learn from
1. Follow the installation approach outlined in the Arch Linux wiki
1. Provide minimal configuration options
1. Provide sane (albeit opinionated) defaults for a minimal Arch "vanilla" Gnome installation
1. Provide optional post-installation capabalities 

### Easy to Follow, Easy to Learn From
The main [soagi.sh](https://github.com/rstrube/soagi/blob/master/soagi.sh) installation script was designed to very easy to follow and understand.  The script itself it not very long, and has comments for each and every action that takes place.

### Follows Arch Wiki Installation
Each and every action in the installation script *directly* correlates to actions that are described in the [Arch Wiki Installation Guide](https://wiki.archlinux.org/index.php/Installation_guide).  The goal here is to provide a learning opportunity for new Arch users, and to not do anything out of the ordinary.

### Miminal Configuration Options
The configuration options can be defined in seconds.  Define some details regarding your hardware (hard drive, CPU, GPU(s)), you locale info, your user information and password, and you're done.

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
XORG_INSTALL="true"

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
```
### Sane (Opinionated) Defaults
Soagi takes a very different approach compared to other installation scripts and utitities - it's very opionated with the *base* system.  As such the core set of packages that are installed doesn't vary much based on your configuration options (the exception being driver related packages).

The list below represents (at a high level) the base system Soagi creates for you:
* UEFI systems only
* Grub bootloader
* Latest Linux Zen kernel
* Latest CPU uCode (AMD or Intel)
* BTRFS filesystem with sane subvolume configuration
* Mesa/Vulkan support for Intel/AMD GPUs
* Nvidia proprietary driver/Vulkan support for Nvidia GPUs
* Gnome
* NetworkManager

Below is a more detailed list of the exact packages that are installed:

**Always Installed:**
```
base base-devel linux-zen linux-zen-headers fwupd xdg-user-dirs man-db man-pages texinfo dosfstools exfatprogs e2fsprogs btrfs-progs networkmanager git vim grub efibootmgr
```

**Systems with AMD CPUs:**
```
linux-firmware amd-ucode
```

**Systems with Intel CPUs:**
```
linux-firmware intel-ucode
```

**Optional Xorg (will use Wayland otherwise):**
```
xorg-server
```

**Gnome:**
```
gnome gnome-tweaks noto-fonts-emoji
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
That's it!

### Post-Installation Capabilities
*Still need some time to document these.*

## Installation
The installation process is quite simple

1. Boot off of the [Arch installation ISO](https://www.archlinux.org/download/)
2. Configure networking
    1. Use `iwctl` for WiFi (see below)
    1. Ethernet should already be setup
3. Download the main sogai installation script
```
curl -O https://raw.githubusercontent.com/rstrube/soagi/master/soagi.sh
```
4. Edit the installation script and setup configuration options

```
vim sogai.sh
```
5. Change permissions on script to make it executable
```
chmod +x soagi.sh
```
6. Execute script
```
./soagi.sh
```
On most modern systems the installation takes between 5-7 minutes.

### Using iwctl to Connect to WiFi for Installation
The Arch Linux Installation ISO comes with `iwctl` which can be used to easily connect to WiFi networks.

After booting up enter the following commands:

1. `iwctl device list` to identify your WiFi device (e.g. `wlp0s20f3`).  Use in place of `{DEVICE}` for the following commands:
1. `iwctl station {DEVICE} scan`
1. `iwctl station {DEVICE} get-networks` should get you a list of SSIDs.  Use your SSID in place of `{SSID}` for the following command:
1. `iwctl station {DEVICE} connect {SSID}` should prompt you to enter in your password to connect to specified network.

Note: Soagi does **not** install `iwctl`, instead NetworkManager is installed, including `nmcli` for command line operations. `iwctl` should *only* be used for installation and is recommended because it comes by default with the Arch Linux Installation ISO.