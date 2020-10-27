#!/bin/bash

#|# VSCode font configuration (requires Gnome fonts)
#|#./ingredients/dev/vscode-2-fonts.sh

DIR=$(dirname "$0")
source $DIR/../_helper/_common-functions.sh

function main() {

    check_critical_prereqs
    install
}

function install() {

    create_empty_vscode_settings_if_neccessary

    echo "Updating VSCode settings.json file with font configuration..."

    sed -i '$i\    "editor.fontFamily": "JetBrains Mono",' "$VSCODE_SETTINGS_FILE_PATH"
    sed -i '$i\    "editor.fontLigatures": true,' "$VSCODE_SETTINGS_FILE_PATH"
}

function check_critical_prereqs() {
    check_yay_prereq
}

main "$@"
