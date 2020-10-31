#!/bin/bash
# recipe.sh : 30-10-2020-20:00:34
# NOTE: Please uncomment the ingredients you wish to install before running!
# ------------------------------------------------------------------------

function main() {

# 1. Core
# ------------------------------------------------------------------------

# Mandatory programs & utilities
./ingredients/core/utils.sh

# Zsh + Oh-my-Zsh (recommended)
./ingredients/core/zsh.sh


# 2. Gnome
# ------------------------------------------------------------------------

# Gnome fonts
#./ingredients/gnome/fonts.sh

# Gnome icons
#./ingredients/gnome/icons.sh

# Gnome Dracula theme
#./ingredients/gnome/theme-dracula-1.sh

# Gnome Dracula theme icons (requires Gnome icons)
#./ingredients/gnome/theme-dracula-2-icons.sh

# Gnome Dracula theme Flatpak support
#./ingredients/gnome/theme-dracula-3-flatpak.sh


# 3. Development
# ------------------------------------------------------------------------

# Git (installation and configuration)
#install git
#git config --global user.name "First Last"
#git config --global user.email "myname@mydomain.com"

# Git Credential Manager (supports Git repos on Azure DevOps)
#install git-credential-manager-bin

# VSCode (OSS Edition)
#install code

# VSCode font configuration (requires Gnome fonts)
#./ingredients/dev/vscode-2-fonts.sh

# VSCode Dracula theme
#./ingredients/dev/vscode-3-dracula-theme.sh


# 4. Web
# ------------------------------------------------------------------------

# Chromium
#install chromium

# Chromium enable VAAPI support (requires Chromium)
#./ingredients/web/chromium-2-enable-vaapi.sh

# Firefox
#install firefox

# Slack
#flatpak install -y flathub com.slack.Slack

# Microsoft Teams
#install teams


# 5. Productivity
# ------------------------------------------------------------------------

# Flameshot (screenshot application)
#install flameshot

# Getting this Gnome (TTD application)
#flatpak install -y flathub org.gnome.GTG


# 6. Media
# ------------------------------------------------------------------------

# Tauon Music Player
#flatpak install -y flathub com.github.taiko2k.tauonmb

# VLC media player and codecs
#install a52dec aribb24 faac faad2 flac jasper lame libdca libdv libdvbpsi libmad libmatroska libmpeg2 libtheora libvorbis libxv opus wavpack x264 xvidcore libdvdcss vlc


# 7. Gaming
# ------------------------------------------------------------------------

# Steam gaming platform
#install steam


# 8. Backup
# ------------------------------------------------------------------------

# Btrbk: Command line btrfs backup utility
# Usage: brtbk.sh {/path/to/src_btr_root_vol} {snapshot-subvolume-name} {/path/to/backup_btr_root_vol} {backup_label}
# Example: btrbk.sh /mnt/btr_root_vol btr_snapshots /run/media/robert/MyBackupHD MyLaptop
#./ingredients/backup/brtbk.sh {/path/to/src_btr_root_vol} {snapshot-subvolume-name} {/path/to/backup_btr_root_vol} {backup_label}


# 9. Hardware Specific CPU
# ------------------------------------------------------------------------

# # Utilities neccessary to undervolt Intel CPUs
#install msr-tools bc


# 10. VM
# ------------------------------------------------------------------------

# KVM/Quem guest utilities (only install if running as VM)
#./ingredients/vm/kvm-qemu-guest.sh

# KVM/Quemu host installation and configuration
#./ingredients/vm/kvm-qemu-host.sh

}

function install() {

    yay -Syu --noconfirm --needed "$@"
}

main "$@"
