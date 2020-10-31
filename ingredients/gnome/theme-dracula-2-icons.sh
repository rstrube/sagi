#!/bin/bash

#|# Gnome Dracula theme icons (requires Gnome icons)
#|#./ingredients/gnome/theme-dracula-2-icons.sh

GNOME_CURRENT_ICON_THEME=$(gsettings get org.gnome.desktop.interface icon-theme)

if [[ "$GNOME_CURRENT_ICON_THEME" == "'Papirus-Dark'" ]]; then

    echo "Setting papirus icons folder color to 'grey' via 'papirus-folders'..."

    yay -Syu --noconfirm --needed papirus-folders
    papirus-folders -C grey --theme Papirus-Dark
fi
