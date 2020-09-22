#!/bin/bash
# Productivity - Getting things Gnome

DIR=$(dirname "$0")
source $DIR/helper/_common-functions.sh

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
