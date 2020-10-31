#!/bin/bash

#|# Gnome Dracula theme
#|#./ingredients/gnome/theme-dracula-1.sh

function main() {

    install
}

function install() {

    configure_gtk_theme
    configure_gnome_terminal_theme
    configure_gedit_theme
}

function configure_gtk_theme {

    echo "Installing Dracula GTK theme..."

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

function configure_gnome_terminal_theme {

    echo "Installing Dracula theme for gnome-terminal..."

    # Reset gnome-terminal
    dconf reset -f /org/gnome/terminal/

    GT_DCONF_DIR=/org/gnome/terminal/legacy/profiles:
    GT_PROFILE_ID="$(uuidgen)"
    GT_DCONF_PROFILE_DIR="${GT_DCONF_DIR}/:$GT_PROFILE_ID"

    GT_PROFILE_NAME="'Dracula'"
    GT_PROFILE_BACKGROUND_COLOR="'#282A36'"
    GT_PROFILE_BOLD_COLOR="'#6E46A4'"
    GT_PROFILE_FOREGROUND_COLOR="'#F8F8F2'"
    GT_PROFILE_PALLETE="['#262626', '#E356A7', '#42E66C', '#E4F34A', '#9B6BDF', '#E64747', '#75D7EC', '#EFA554', '#7A7A7A', '#FF79C6', '#50FA7B', '#F1FA8C', '#BD93F9', '#FF5555', '#8BE9FD', '#FFB86C']"

    dconf write ${GT_DCONF_DIR}/default "'$GT_PROFILE_ID'"
    dconf write ${GT_DCONF_DIR}/list "['$GT_PROFILE_ID']"

    dconf write ${GT_DCONF_PROFILE_DIR}/background-color $GT_PROFILE_BACKGROUND_COLOR
    dconf write ${GT_DCONF_PROFILE_DIR}/bold-color $GT_PROFILE_BOLD_COLOR
    dconf write ${GT_DCONF_PROFILE_DIR}/bold-color-same-as-fg "false"
    dconf write ${GT_DCONF_PROFILE_DIR}/foreground-color $GT_PROFILE_FOREGROUND_COLOR
    dconf write ${GT_DCONF_PROFILE_DIR}/palette "$GT_PROFILE_PALLETE"
    dconf write ${GT_DCONF_PROFILE_DIR}/use-theme-colors "false"
    dconf write ${GT_DCONF_PROFILE_DIR}/visible-name $GT_PROFILE_NAME
}

function configure_gedit_theme {

    echo "Installing Dracula theme for gedit..."

    curl -O https://raw.githubusercontent.com/dracula/gedit/master/dracula.xml

    GEDIT_STYLE_PATH=$HOME/.local/share/gedit/styles

    if [[ ! -d $GEDIT_STYLE_PATH ]]; then
        mkdir -p $GEDIT_STYLE_PATH
    fi

    mv dracula.xml $GEDIT_STYLE_PATH
    
    gsettings set org.gnome.gedit.preferences.editor scheme 'dracula'
}

main "$@"
