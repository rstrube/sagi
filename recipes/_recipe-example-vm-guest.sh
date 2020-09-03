#!/bin/bash
# Example soagi post-install recipe KVM/Qemu guest VM
# (also used to test post_install scripts...)

cd ../post_install

# KVM/QEMU guest utilities
./vm_kvm-qemu-guest.sh

# Core applications / utilities
./core_yay.sh
./core_utils.sh
./core_zsh.sh

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
./gnome_theme-dracula.sh --configure-vscode-theme --configure-flatpak-theme
