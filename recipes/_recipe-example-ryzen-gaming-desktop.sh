#!/bin/bash
# Example soagi post-install recipe for gaming desktop (AMD Ryzen CPU + Nvidia GPU)

cd ../ingredients

# Core applications / utilities
./core/yay.sh
./core/utils.sh
./core/reflector.sh
./core/zsh.sh

# Web applications / utilities
# Note: because this system has a Nvidia GPU, don't enable VAAPI for Chromium
./web/chromium.sh

# Development applications / utilities
./dev/git.sh "Robert Strube" robert@mydomain.com

# Media
./media/codecs-player.sh

# Gnome
./gnome/gdm-startup-fix.sh

# Icons / Fonts / Themes
./gnome/icons.sh
./gnome/fonts.sh
./gnome/theme-dracula.sh --configure-papirus-folder-theme --configure-vscode-theme --configure-flatpak-theme

# Gaming
./gaming/steam.sh
