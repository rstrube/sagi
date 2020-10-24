#!/bin/bash
# recipe-example-sys76-laptop.sh
# Example recipe: This recipe is for my System76 laptop (Darter Pro)

# Core
# -------------------------
./ingredients/core/utils.sh # Core utilities
./ingredients/core/yay.sh # Yay: let's you easily install packages for AUR
./ingredients/core/zsh.sh # Zsh + Oh-my-Zsh: fanstatic shell with built in support for git repos

# Development
# -------------------------
# Git
# Usage: git.sh "Full Name" {email} [--git-credential-manager]
# Note: Git credential manager provides support for Microsoft Azure DevOps authentication
./ingredients/dev/git.sh "Robert Strube" robert@mydomain.com --git-credential-manager
# ------------------------
./ingredients/dev/vscode.sh # Visual Studio Code (OSS Version): Incredible open source IDE

# Gnome
# -------------------------
# Gnome Font Configuration
# Usage: fonts.sh [--configure-vscode-fonts]
./ingredients/gnome/fonts.sh --configure-vscode-fonts
# ------------------------
# Gnome GDM Fix
./ingredients/gnome/gdm-startup-fix.sh # Fixes a race condition with GDM preventing it from being displayed on fast systems
# ------------------------
# Gnome Icon Configuration
./ingredients/gnome/icons.sh
# ------------------------
# Gnome Dracula Theme
# Usage: theme-dracula.sh [--configure-vscode-theme] [--configure-flatpak-theme] [--configure-papirus-folder-theme]
./ingredients/gnome/theme-dracula.sh --configure-vscode-theme --configure-flatpak-theme --configure-papirus-folder-theme
# ------------------------

# Web
# -------------------------
# Chromium
# Usage: chromium.sh [--enable-vaapi]
# Note: VAAPI only works with Intel/AMD GPUs
./ingredients/web/chromium.sh --enable-vaapi
# ------------------------
./ingredients/web/firefox.sh # Firefox
./ingredients/web/slack.sh # Slack
./ingredients/web/teams.sh # Microsoft Teams

# Productivity
# -------------------------
./ingredients/productivity/flameshot.sh # Flameshot: Incredible screenshot application
./ingredients/productivity/gtg.sh # Getting things Gnome
./ingredients/productivity/standardnotes.sh # StandardNotes

# Media
# -------------------------
./ingredients/media/codecs-player.sh # VLC video player and important codecs
./ingredients/media/tauon-music-player.sh # Tauon Music Player: fantastic music library browser and player

# Gaming
# -------------------------
#./ingredients/gaming/steam.sh # Steam: Digital distribution platform for PC games

# Backup
# -------------------------
# Btrbk: Command line btrfs backup utility
# Usage: brtbk.sh {/path/to/src_btr_root_vol} {snapshot-subvolume-name} {/path/to/backup_btr_root_vol} {backup_label}
# Example: btrbk.sh /mnt/btr_root_vol btr_snapshots /run/media/robert/MyBackupHD MyLaptop
#./ingredients/backup/brtbk.sh {/path/to/src_btr_root_vol} {snapshot-subvolume-name} {/path/to/backup_btr_root_vol} {backup_label}
# ------------------------

# Hardware Specific CPU
# -------------------------
./ingredients/cpu/intel-undervolt-support.sh # Utilities neccessary to undervolt Intel CPUs

# VM
# -------------------------
#./ingredients/vm/kvm-qemu-guest.sh # KVM/Qemu tools for guest VMs (only install if this system is a guest VM!)
./ingredients/vm/kvm-qemu-host.sh # KVM/Qemu: Support for running VMs
