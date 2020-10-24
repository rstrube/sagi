#!/bin/bash
# Gnome - GDM Startup Fix

#|# Gnome GDM Fix
#|./ingredients/gnome/gdm-startup-fix.sh # Fixes a race condition with GDM preventing it from being displayed on fast systems
#|# ------------------------

DIR=$(dirname "$0")
source $DIR/../_helper/_common-functions.sh

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
