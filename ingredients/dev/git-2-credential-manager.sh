#!/bin/bash

#|# Git Credential Manager (supports Git repos on Azure DevOps)
#|#./ingredients/dev/git-2-credential-manager.sh

DIR=$(dirname "$0")
source $DIR/../_helper/_common-functions.sh

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
