#!/bin/bash
# Example soagi post-install recipe for System76 laptop (work machine)

cd ../post_install

# Core applications / utilities
./core_yay.sh
./core_utils.sh
./core_zsh.sh
./core_btrbk.sh /mnt/btr_root_vol btr_snapshots /mnt/btr_ext_ssd sys76

# CPU specific utilities
./cpu_intel-undervolt-support.sh

# Web applications / utilities
./web_chromium.sh --enable-vaapi
./web_slack.sh
./web_teams.sh

# Development applications / utilities
./dev_git.sh "Robert Strube" robert@mydomain.com --install-git-credential-manager
./dev_vscode.sh

# Media
./media_codecs-player.sh

# Icons / Fonts / Themes
./gnome_icons.sh
./gnome_fonts.sh --configure-vscode-fonts
./gnome_theme-dracula.sh --configure-papirus-folder-theme --configure-vscode-theme --configure-flatpak-theme
