#!/bin/bash
# Gnome - Common Fonts

# Install the following fonts:
# Fira Code: https://github.com/tonsky/FiraCode
# Fira Code has been patched to support "Powerline" symbols that oh-my-zsh requires
# Roboto: default font for Google's Android OS
# Jetbrains Mono: a fantastic monospace font
yay -Syu --noconfirm --needed ttf-fira-code ttf-roboto ttf-roboto-slab ttf-jetbrains-mono

# This rebuilds the font-cache, taking into account any changes
sudo fc-cache -r -v

# Configure Gnome to use newly installed fonts
gsettings set org.gnome.desktop.interface font-name "Roboto 10"
gsettings set org.gnome.desktop.interface document-font-name "Roboto Slab 11"
gsettings set org.gnome.desktop.interface monospace-font-name "JetBrains Mono 11"
gsettings set org.gnome.desktop.wm.preferences titlebar-font "Roboto Medium 10"
