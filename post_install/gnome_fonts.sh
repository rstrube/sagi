#!/bin/bash
# Gnome - Fonts

source _common-functions.sh

CONFIGURE_VSCODE_FONTS="false"
ARG_CONFIGURE_VSCODE_FONTS="--configure-vscode-fonts"

function main() {

    check_args "$@"

    if [[ "$1" == "$ARG_CONFIGURE_VSCODE_FONTS" ]]; then
        CONFIGURE_VSCODE_FONTS="true"
    fi

    check_variables
    check_critical_prereqs
    install
}

function install() {
    # Install the following fonts:
    # Fira Code: https://github.com/tonsky/FiraCode
    # Roboto: default font for Google's Android OS
    # Jetbrains Mono: a fantastic monospace font
    yay -Syu --noconfirm --needed ttf-fira-code ttf-roboto ttf-roboto-slab ttf-jetbrains-mono

    # This rebuilds the font-cache, taking into account any changes
    sudo fc-cache -r -v

    # Configure Gnome to use newly installed fonts
    gsettings set org.gnome.desktop.interface font-name "Roboto 10"
    gsettings set org.gnome.desktop.interface document-font-name "Roboto Slab 11"
    gsettings set org.gnome.desktop.interface monospace-font-name "JetBrains Mono 11"
    gsettings set org.gnome.desktop.wm.preferences titlebar-font "Roboto Medium 10"

    if [[ "$CONFIGURE_VSCODE_FONTS" == "true" ]]; then
        configure_vscode_fonts
    fi
}

function configure_vscode_fonts {

    create_empty_vscode_settings_if_neccessary

    echo "Updating VSCode settings.json file with font configuration..."

    sed -i '$i\    "editor.fontFamily": "JetBrains Mono",' "$VSCODE_SETTINGS_FILE_PATH"
    sed -i '$i\    "editor.fontLigatures": true,' "$VSCODE_SETTINGS_FILE_PATH"
}

function check_args() {
    
    if [[ "$#" -gt 1 ]]; then
        echo -e "${RED}Error: this script can be run with a maximum of one argument.${NC}"
        echo -e "${LIGHT_BLUE}Usage:   "$0" [${ARG_CONFIGURE_VSCODE_FONTS}]${NC}"
        echo -e "${BLUE}${ARG_CONFIGURE_VSCODE_FONTS}${NC} : [optional] configures fonts for VSCode."
        exit 1
    fi
}

function check_variables() {

    check_variables_boolean "CONFIGURE_VSCODE_FONTS" "$CONFIGURE_VSCODE_FONTS"
}

function check_critical_prereqs() {
    check_yay_prereq
}

main "$@"
