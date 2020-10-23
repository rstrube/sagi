#!/bin/bash
# Example soagi post-install recipe KVM/Qemu guest VM

cd ../ingredients

# KVM/QEMU guest utilities
./vm/kvm-qemu-guest.sh

# Core applications / utilities
./core/yay.sh
./core/utils.sh
./core/reflector.sh
./core/zsh.sh
./core/btrbk.sh /mnt/btr_root_vol btr_snapshots /mnt/btr_ext_ssd sys76

# Web applications / utilities
./web/chromium.sh --enable-vaapi
./web/firefox.sh

# Development applications / utilities
./dev/git.sh "Robert Strube" robert@mydomain.com --install-git-credential-manager

# Gnome
./gnome/gdm-startup-fix.sh

# Icons / Fonts / Themes
./gnome/icons.sh
./gnome/fonts.sh
./gnome/theme-dracula.sh --configure-papirus-folder-theme --configure-vscode-theme --configure-flatpak-them
