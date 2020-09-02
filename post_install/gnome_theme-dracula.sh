#!/bin/bash
# Gnome - Theme (Dracula)

curl -O -L https://github.com/dracula/gtk/archive/master.zip

if [[ -d ~/.local/share/themes/Dracula ]]; then
    echo "Deleting existing locally installed Dracula GTK theme..."
    rm -rf ~/.local/share/themes/Dracula
fi

mkdir -p ~/.local/share/themes

unzip master.zip -d ~/.local/share/themes
mv ~/.local/share/themes/gtk-master ~/.local/share/themes/Dracula

rm master.zip

# Get GTK theme to Dracula (which was locally installed in ~/.local/share/themes)
gsettings set org.gnome.desktop.interface gtk-theme "Dracula"
gsettings set org.gnome.desktop.wm.preferences theme "Dracula"
