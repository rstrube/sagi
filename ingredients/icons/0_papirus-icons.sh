#!/bin/bash
#|#./ingredients/icons/0_papirus-icons.sh #Papirus icon theme

paru -S --noconfirm --needed papirus-icon-theme

# Configure Gnome to use the Papirus-Dark icon theme
gsettings set org.gnome.desktop.interface icon-theme "Papirus-Dark"
