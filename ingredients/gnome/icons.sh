#!/bin/bash
#|#./ingredients/gnome/icons.sh #Gnome icons

paru -Syu --noconfirm --needed papirus-icon-theme

# Configure Gnome to use the Papirus-Dark icon theme
gsettings set org.gnome.desktop.interface icon-theme "Papirus-Dark"
