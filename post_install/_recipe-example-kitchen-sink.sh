#!/bin/bash
# Soagi Post-Install Recipe (Kitchen Sink)

# Core applications / utilities
./core-yay.sh
./core-zsh.sh
./core-btrbk.sh /mnt/btr_root_vol btr_snapshots /run/media/robert/MyBackupHD myLaptop

# Web applications / utilities
./web-chromium.sh --enable-vaapi
./web_slack
./web_teams

# Development applications / utilities
./dev_git.sh --install-git-credential-manager
./dev_vscode.sh

# Icons / Fonts / Themes
./gnome_icons.sh
./gnome_fonts --configure-vscode-fonts
./gnome_theme-dracula --configure-vscode-theme --configure-flatpak-theme
