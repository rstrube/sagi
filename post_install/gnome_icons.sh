#!/bin/bash
# Gnome - Icons

source helper/_common-functions.sh

sudo pacman -Syu --noconfirm --needed papirus-icon-theme

# Configure Gnome to use the Papirus-Dark icon theme
gsettings set org.gnome.desktop.interface icon-theme "Papirus-Dark"
