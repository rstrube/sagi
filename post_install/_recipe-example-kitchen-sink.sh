#!/bin/bash
# Soagi Post-Install Recipe (Kitchen Sink)

# Core applications / utilities
./core_yay.sh
./core_zsh.sh
./core_btrbk.sh /mnt/btr_root_vol btr_snapshots /run/media/robert/MyBackupHD myLaptop

# Web applications / utilities
./web_chromium.sh --enable-vaapi
./web_slack.sh
./web_teams.sh

# Development applications / utilities
./dev_git.sh --install-git-credential-manager
./dev_vscode.sh

# Media
./media_codecs-player.sh

# Icons / Fonts / Themes
./gnome_icons.sh
./gnome_fonts.sh --configure-vscode-fonts
./gnome_theme-dracula.sh --configure-vscode-theme --configure-flatpak-theme
