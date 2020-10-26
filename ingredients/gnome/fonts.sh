#!/bin/bash

#|# Gnome fonts
#|#./ingredients/gnome/fonts.sh

DIR=$(dirname "$0")
source $DIR/../_helper/_common-functions.sh

function main() {

    check_critical_prereqs
    install
}

function install() {
    # Install the following fonts:
    # Fira Code: https://github.com/tonsky/FiraCode
    # Roboto: default font for Google's Android OS
    # Jetbrains Mono: a fantastic monospace font
    # Droid: another common font that came with Google's Android OS
    yay -Syu --noconfirm --needed ttf-fira-code ttf-roboto ttf-roboto-slab ttf-jetbrains-mono ttf-droid

    # This rebuilds the font-cache, taking into account any changes
    sudo fc-cache -r -v

    # Configure Gnome to use newly installed fonts
    gsettings set org.gnome.desktop.interface font-name "Roboto 10"
    gsettings set org.gnome.desktop.interface document-font-name "Roboto Slab 11"
    gsettings set org.gnome.desktop.interface monospace-font-name "JetBrains Mono 11"
    gsettings set org.gnome.desktop.wm.preferences titlebar-font "Roboto Medium 10"
}

function check_critical_prereqs() {
    check_yay_prereq
}

main "$@"
