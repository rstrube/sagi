#!/bin/bash
# Web - Slack

source _sh-functions.sh

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
