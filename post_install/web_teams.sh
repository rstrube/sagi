#!/bin/bash
# Web - Teams

source _common-functions.sh

function main() {
    check_critical_prereqs
    install
}

function install() {
    yay -Syu --noconfirm --needed teams
}

function check_critical_prereqs() {
    check_yay_prereq
}

main "$@"
