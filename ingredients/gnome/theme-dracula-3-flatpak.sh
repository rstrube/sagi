#!/bin/bash
#|#./ingredients/gnome/theme-dracula-3-flatpak.sh #Gnome Dracula theme Flatpak support

# remove existing flatpak theme (created with pakitheme previously)
flatpak remove -y org.gtk.Gtk3theme.Dracula

curl -O https://raw.githubusercontent.com/refi64/pakitheme/master/pakitheme
chmod +x ./pakitheme

echo "Creating local flatpak GTK theme based on Dracula GTK theme..."

./pakitheme install-user
rm pakitheme
