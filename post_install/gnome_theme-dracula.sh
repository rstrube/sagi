#!/bin/bash
# Gnome - Theme (Dracula)

source _common-functions.sh

function main() {
    #install
    configure_vscode_theme
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
}

function configure_vscode_theme {

    create_empty_vscode_settings_if_neccessary

    code --install-extension dracula-theme.theme-dracula

    sed -i '$i\    "workbench.colorTheme": "Dracula",' "$VSCODE_SETTINGS_FILE_PATH"
}

main "$@"
