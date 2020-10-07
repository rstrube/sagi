#!/bin/bash
# Gnome - GDM Startup Fix

DIR=$(dirname "$0")
source $DIR/helper/_common-functions.sh

function main() {
    check_critical_prereqs
    install
}

function install() {
    sudo sed -i '/^\[Service\]/a ExecStartPre=\/bin\/sleep 2' /usr/lib/systemd/system/gdm.service
}

function check_critical_prereqs() {
    
    if [[ -n "$(grep "^ExecStartPre=\/bin\/sleep 2" /usr/lib/systemd/system/gdm.service)" ]]; then
        echo "GDM startup fix already applied! Skipping..."
        exit 1
    fi
}

main "$@"
