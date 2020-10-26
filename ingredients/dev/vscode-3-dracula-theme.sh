#!/bin/bash

#|# VSCode Dracula theme
#|#./ingredients/dev/vscode-3-dracula-theme.sh

DIR=$(dirname "$0")
source $DIR/../_helper/_common-functions.sh

function main() {

    check_critical_prereqs
    install
}

function install() {

    create_empty_vscode_settings_if_neccessary
    code --install-extension dracula-theme.theme-dracula
    sed -i '$i\    "workbench.colorTheme": "Dracula",' "$VSCODE_SETTINGS_FILE_PATH"
}

function check_critical_prereqs() {
    check_yay_prereq
}

main "$@"
