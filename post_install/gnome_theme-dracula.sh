#!/bin/bash
# Gnome - Theme (Dracula)

source _common-functions.sh

CONFIGURE_VSCODE_THEME="false"
ARG_CONFIGURE_VSCODE_THEME="--configure-vscode-theme"
CONFIGURE_FLATPAK_THEME="false"
ARG_CONFIGURE_FLATPAK_THEME="--configure-flatpak-theme"

function main() {

    check_args "$@"

    if [[ "$1" == "$ARG_CONFIGURE_VSCODE_THEME" || "$2" == "$ARG_CONFIGURE_VSCODE_THEME" ]]; then
        CONFIGURE_VSCODE_THEME="true"
    fi

    if [[ "$1" == "$ARG_CONFIGURE_FLATPAK_THEME" || "$2" == "$ARG_CONFIGURE_FLATPAK_THEME" ]]; then
        CONFIGURE_FLATPAK_THEME="true"
    fi

    check_variables
    install
}

function install() {

    curl -O -L https://github.com/dracula/gtk/archive/master.zip

    if [[ -d ~/.local/share/themes/Dracula ]]; then
        echo "Deleting existing locally installed Dracula GTK theme..."
        rm -rf ~/.local/share/themes/Dracula
    fi

    mkdir -p ~/.local/share/themes

    unzip master.zip -d ~/.local/share/themes
    mv ~/.local/share/themes/gtk-master ~/.local/share/themes/Dracula

    rm master.zip

    # Get GTK theme to Dracula (which was locally installed in ~/.local/share/themes)
    gsettings set org.gnome.desktop.interface gtk-theme "Dracula"
    gsettings set org.gnome.desktop.wm.preferences theme "Dracula"

    if [[ "$CONFIGURE_VSCODE_THEME" == "true" ]]; then
        configure_vscode_theme
    fi

    if [[ "$CONFIGURE_FLATPAK_THEME" == "true" ]]; then
        configure_flatpak_theme
    fi
}

function configure_vscode_theme {

    create_empty_vscode_settings_if_neccessary
    
    echo "Installing Dracula theme VSCode extension..."

    code --install-extension dracula-theme.theme-dracula

    echo "Updating VSCode settings.json file with theme configuration..."

    sed -i '$i\    "workbench.colorTheme": "Dracula",' "$VSCODE_SETTINGS_FILE_PATH"
}

function configure_flatpak_theme {

    curl -O https://raw.githubusercontent.com/refi64/pakitheme/master/pakitheme
    chmod +x ./pakitheme

    echo "Creating local flatpak GTK theme based on Dracula GTK theme..."

    ./pakitheme install-user
    rm pakitheme
}

function check_args() {
    
    if [[ "$#" -gt 2 ]]; then
        echo -e "${RED}Error: this script can be run with a maximum of two arguments.${NC}"
        echo -e "${LIGHT_BLUE}Usage: "$0" [${ARG_CONFIGURE_VSCODE_THEME}] [${ARG_CONFIGURE_FLATPAK_THEME}]${NC}"
        echo -e "${BLUE}${ARG_CONFIGURE_VSCODE_THEME}${NC}  : [optional] configures Dracula theme for VSCode."
        echo -e "${BLUE}${ARG_CONFIGURE_FLATPAK_THEME}${NC} : [optional] installs Dracula theme locally for flatpak applications."
        exit 1
    fi
}

function check_variables() {

    check_variables_boolean "CONFIGURE_VSCODE_THEME" "$CONFIGURE_VSCODE_THEME"
    check_variables_boolean "CONFIGURE_FLATPAK_THEME" "$CONFIGURE_FLATPAK_THEME"
}

main "$@"
