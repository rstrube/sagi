# sagi (Simple Arch Gnome Installer)
Sagi is a concise, easy to follow installation script for Arch linux which results in a minimal Arch "vanilla" Gnome installation.

## Using sagi to install Arch Linux
1. Boot off of latest version of the Arch Linux ISO
1. Configure networking
1. Download script
1. Determine block devices
1. Edit script
1. Run script

### 1. Boot off of the latest version of the Arch Linux ISO
[Download](https://archlinux.org/download/) the latest version of the Arch Linux ISO and create a bootable USB flash drive.  You can find more instructions on the official [Arch Linux Wiki](https://wiki.archlinux.org/title/Installation_guide#Acquire_an_installation_image).

I pefer using [Ventoy](https://www.ventoy.net/) for creating my bootable USB flash drives as you can store multiple ISOs on a single USB flash drive.

### 2. Configuring networking
If you are using an ethernet connection your networking should be automatically configured.

If you're using WiFi you'll need to use the `iwctl` utility to connect to your wireless network.

1. `iwctl device list` to identify your WiFi device (e.g. `wlp0s20f3`).  Use in place of `{DEVICE}` for the following commands:
1. `iwctl station {DEVICE} scan`
1. `iwctl station {DEVICE} get-networks` should get you a list of SSIDs.  Use your SSID in place of `{SSID}` for the following command:
1. `iwctl station {DEVICE} connect {SSID}` should prompt you to enter in your password to connect to specified network.

Sagi does **not** install `iwctl`, instead NetworkManager is installed, including `nmcli` for command line operations, and `nmtui` for a terminal based graphical way to configure your network settings. `iwctl` should *only* be used for installation and is recommended because it comes by default with the Arch Linux Installation ISO.

### 3. Download script
Download the sagi installation script:

```shell
$> curl -O https://raw.githubusercontent.com/rstrube/sagi/main/sagi.sh
```
### 4. Determine block devices
List out your block devices:

```shell
$> lsblk
NAME        MAJ:MIN RM   SIZE RO TYPE MOUNTPOINTS
nvme0n1     259:0    0 931.5G  0 disk 
├─nvme0n1p1 259:1    0   511M  0 part /boot
└─nvme0n1p2 259:2    0   931G  0 part /
```
Note the HD device you wish to install Arch Linux to.

*Common HD device names are:*
* SATA HDs are usually something like: `/dev/sdx` (e.g. `/dev/sda`)
* NVME HDs are usually something like: `/dev/nvme0n1`
* KVM/Qemu VM HDs are usually: `/dev/vda`

### 5. Edit script
Edit the sagi installation script using your favorite text editor (I prefer Vim). You'll need to supply several variable values located at the top of the script.  These variables are heavily commented in order to help you.

```bash
#!/bin/bash
# Simple Arch Gnome Installer

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
# To list out all timezones in a given region run "ls -l /usr/share/zoneinfo/{region}" e.g. "ls -l /usr/share/zoneinfo/America"
# To list out all timezones run "timedatectl list-timezones"
# To examine available locales look in /etc/locale.gen, first column is used for LANG, both columns together are used for LOCALE
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
CMDLINE_LINUX="" #"msr.allow_writes=on"

# Uncomment to enable the installation log
#LOG_FILE="sagi.log"
```
### 6. Run script
Update the permissions of the script and run it:

```shell
chmod +x sagi.sh
./sagi.sh
```
You will have an opportunity to view your configuration before beginning the installation:

![Confirmation](https://github.com/rstrube/sagi/blob/main/doc/img/confirmation.png)

On most modern systems the installation will take around 5 minutes.

*Note: If any required variables are not set, the script will not run and return an error.  If there are conflicting variable values, the script will also not run and return an error.*

The end result will be a clean "vanilla" Gnome Arch Linux installation:

![Base Sagi Installation Result](https://github.com/rstrube/sagi/blob/main/doc/img/base-install.png)

## Inspiration
Sagi was heavily inspired by [alis (Arch Linx Install Script)](https://github.com/picodotdev/alis).  alis is extremely customizable and offers a wide variety of installation options, filesystems, partitioning schemes, packages, DEs' etc. but for many people that just want to get up and running on Arch quickly it can provide *too many* options.

## Goals
Sagi has the following goals:
1. Be easy to follow and learn from
1. Follow the installation approach outlined in the Arch Linux wiki
1. Provide minimal configuration options
1. Provide sane (albeit opinionated) defaults for a minimal Arch "vanilla" Gnome installation

### Easy to follow, easy to learn
The main [sagi.sh](https://github.com/rstrube/sagi/blob/main/sagi.sh) installation script was designed to very easy to follow and understand.  The script itself it not very long, and has comments for each and every action that takes place.

### Follows Arch Wiki Installation Guide
Each and every action in the installation script *directly* correlates to actions that are described in the [Arch Wiki Installation Guide](https://wiki.archlinux.org/index.php/Installation_guide).  The goal here is to provide a learning opportunity for new Arch users, and to not do anything out of the ordinary.

### Miminal configuration
The configuration options can be defined in seconds.  Define some hardware details (HD, CPU, GPU(s)), locale info, user information and password, etc. and you're done!

### Sane Defaults
Sagi installs a "sane" set of packages.  As such the core set of packages that are installed doesn't vary much based on your configuration options (the exception being driver related packages).

The list below represents (at a high level) the base system Sagi creates for you:
* UEFI systems only
* Systemd bootloader
* Latest Linux kernel
* ext4 filesystem
* Swapfile
* Latest CPU uCode (AMD or Intel)
* Mesa/Vulkan support for Intel/AMD GPUs
* Nvidia proprietary driver/Vulkan support for Nvidia GPUs
* Gnome
* NetworkManager
* Pipewire
