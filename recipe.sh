#!/bin/bash
# recipe.sh : 27-10-2020-13:50:05
# NOTE: Please uncomment the ingredients you wish to install before running!
# ------------------------------------------------------------------------

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

# GDM startup fix (fixes race condition where GDM doesn't initialize correctly on fast systems)
./ingredients/gnome/gdm-startup-fix.sh

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
# Usage: git-1.sh "{full name}" {email}
#./ingredients/dev/git-1.sh "First Last" robert@mydomain.com

# Git Credential Manager (supports Git repos on Azure DevOps)
#./ingredients/dev/git-2-credential-manager.sh

# VSCode (OSS Edition)
#./ingredients/dev/vscode-1.sh

# VSCode font configuration (requires Gnome fonts)
#./ingredients/dev/vscode-2-fonts.sh

# VSCode Dracula theme
#./ingredients/dev/vscode-3-dracula-theme.sh


# 4. Web
# ------------------------------------------------------------------------

# Chromium
#./ingredients/web/chromium-1.sh

# Chromium enable VAAPI support (requires Chromium)
#./ingredients/web/chromium-2-enable-vaapi.sh

# Firefox
#./ingredients/web/firefox.sh

# Slack
#./ingredients/web/slack.sh

# Microsoft Teams
#./ingredients/web/teams.sh


# 5. Productivity
# ------------------------------------------------------------------------

# Flameshot (screenshot application)
#./ingredients/productivity/flameshot.sh

# Getting this Gnome (TTD application)
#./ingredients/productivity/gtg.sh # Getting things Gnome


# 6. Media
# ------------------------------------------------------------------------

# Tauon Music Player
#./ingredients/media/tauon-music-player.sh

# VLC media player and codecs
#./ingredients/media/vlc-codecs.sh


# 7. Gaming
# ------------------------------------------------------------------------

# Steam gaming platform
#./ingredients/gaming/steam.sh


# 8. Backup
# ------------------------------------------------------------------------

# Btrbk: Command line btrfs backup utility
# Usage: brtbk.sh {/path/to/src_btr_root_vol} {snapshot-subvolume-name} {/path/to/backup_btr_root_vol} {backup_label}
# Example: btrbk.sh /mnt/btr_root_vol btr_snapshots /run/media/robert/MyBackupHD MyLaptop
#./ingredients/backup/brtbk.sh {/path/to/src_btr_root_vol} {snapshot-subvolume-name} {/path/to/backup_btr_root_vol} {backup_label}


# 9. Hardware Specific CPU
# ------------------------------------------------------------------------

# # Utilities neccessary to undervolt Intel CPUs
#./ingredients/cpu/intel-undervolt-support.sh 


# 10. VM
# ------------------------------------------------------------------------

# KVM/Quem guest utilities (only install if running as VM)
#./ingredients/vm/kvm-qemu-guest.sh

# KVM/Quemu host installation and configuration
#./ingredients/vm/kvm-qemu-host.sh

