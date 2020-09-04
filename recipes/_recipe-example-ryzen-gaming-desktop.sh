#!/bin/bash
# Example soagi post-install recipe for gaming desktop (AMD Ryzen CPU + Nvidia GPU)

cd ../post_install

# Core applications / utilities
./core_yay.sh
./core_utils.sh
./core_zsh.sh

# Web applications / utilities
# Note: because this system has a Nvidia GPU, don't enable VAAPI for Chromium
./web_chromium.sh

# Development applications / utilities
./dev_git.sh "Robert Strube" robert@mydomain.com

# Media
./media_codecs-player.sh

# Icons / Fonts / Themes
./gnome_icons.sh
./gnome_fonts.sh --configure-vscode-fonts
./gnome_theme-dracula.sh --configure-papirus-folder-theme --configure-vscode-theme --configure-flatpak-theme

# Gaming
./gaming_steam.sh
