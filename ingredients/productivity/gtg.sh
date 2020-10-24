#!/bin/bash
# Productivity - Getting things Gnome

#|#./ingredients/productivity/gtg.sh # Getting things Gnome

DIR=$(dirname "$0")
source $DIR/../_helper/_common-functions.sh

function main() {
    check_critical_prereqs
    install
}

function install() {
    flatpak install -y flathub org.gnome.GTG
}

function check_critical_prereqs() {
    check_flatpak_prereq
}

main "$@"
