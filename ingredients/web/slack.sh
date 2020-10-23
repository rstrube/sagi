#!/bin/bash
# Web - Slack (flatpak)

DIR=$(dirname "$0")
source $DIR/../_helper/_common-functions.sh

function main() {
    check_critical_prereqs
    install
}

function install() {
    flatpak install -y flathub com.slack.Slack
}

function check_critical_prereqs() {
    check_flatpak_prereq
}

main "$@"
