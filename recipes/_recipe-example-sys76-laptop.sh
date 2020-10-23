#!/bin/bash
# Example soagi post-install recipe for System76 laptop (Intel CPU and iGPU)

cd ../ingredients

# Core applications / utilities
./core/yay.sh
./core/utils.sh
./core/reflector.sh
./core/zsh.sh
./core/btrbk.sh /mnt/btr_root_vol btr_snapshots /mnt/btr_ext_ssd sys76

# CPU specific utilities
./cpu/intel-undervolt-support.sh

# Web applications / utilities
./web/chromium.sh --enable-vaapi
./web/firefox.sh
./web/slack.sh
./web/teams.sh

# Development applications / utilities
./dev/git.sh "Robert Strube" robert@mydomain.com --install-git-credential-manager
./dev/vscode.sh

# Media
./media/codecs-player.sh
./media/tauon-music-player.sh

# Productivity
./productivity/gtg.sh
./productivity/flameshot.sh
./productivity/standardnotes.sh

# Gnome
./gnome/gdm-startup-fix.sh

# Icons / Fonts / Themes
./gnome/icons.sh
./gnome/fonts.sh --configure-vscode-fonts
./gnome/theme-dracula.sh --configure-papirus-folder-theme --configure-vscode-theme --configure-flatpak-theme
