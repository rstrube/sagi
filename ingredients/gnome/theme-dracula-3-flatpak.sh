#!/bin/bash

#|# Gnome Dracula theme Flatpak support
#|#./ingredients/gnome/theme-dracula-3-flatpak.sh

DIR=$(dirname "$0")
source $DIR/../_helper/_common-functions.sh

function main() {

    install
}

function install() {

    # remove existing flatpak theme (created with pakitheme previously)
    flapack remove -y org.gtk.Gtk3theme.Dracula

    curl -O https://raw.githubusercontent.com/refi64/pakitheme/master/pakitheme
    chmod +x ./pakitheme

    echo "Creating local flatpak GTK theme based on Dracula GTK theme..."

    ./pakitheme install-user
    rm pakitheme
}

main "$@"
