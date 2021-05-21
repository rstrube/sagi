#!/bin/bash
#|#./ingredients/themes/dracula-gedit.sh #Dracula theme for gedit

# Please refer to https://draculatheme.com/contribute/ for a full list of hex codes

function main() {

    install
}

function install() {

    configure_gedit_theme
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
