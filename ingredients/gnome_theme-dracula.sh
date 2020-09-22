#!/bin/bash
# Gnome - Theme (Dracula)

DIR=$(dirname "$0")
source $DIR/helper/_common-functions.sh

CONFIGURE_VSCODE_THEME="false"
ARG_CONFIGURE_VSCODE_THEME="--configure-vscode-theme"
CONFIGURE_FLATPAK_THEME="false"
ARG_CONFIGURE_FLATPAK_THEME="--configure-flatpak-theme"
CONFIGURE_PAPIRUS_FOLDER_THEME="false"
ARG_CONFIGURE_PAPIRUS_FOLDER_THEME="--configure-papirus-folder-theme"

function main() {

    check_args "$@"

    if [[ "$1" == "$ARG_CONFIGURE_VSCODE_THEME" || "$2" == "$ARG_CONFIGURE_VSCODE_THEME" || "$3" == "$ARG_CONFIGURE_VSCODE_THEME" ]]; then
        CONFIGURE_VSCODE_THEME="true"
    fi

    if [[ "$1" == "$ARG_CONFIGURE_FLATPAK_THEME" || "$2" == "$ARG_CONFIGURE_FLATPAK_THEME" || "$3" == "$ARG_CONFIGURE_FLATPAK_THEME" ]]; then
        CONFIGURE_FLATPAK_THEME="true"
    fi

    if [[ "$1" == "$ARG_CONFIGURE_PAPIRUS_FOLDER_THEME" || "$2" == "$ARG_CONFIGURE_PAPIRUS_FOLDER_THEME" || "$3" == "$ARG_CONFIGURE_PAPIRUS_FOLDER_THEME" ]]; then
        CONFIGURE_PAPIRUS_FOLDER_THEME="true"
    fi

    check_variables
    install
}

function install() {

    configure_gtk_theme
    configure_gnome_terminal_theme
    configure_gedit_theme

    if [[ "$CONFIGURE_VSCODE_THEME" == "true" ]]; then
        configure_papirus_folder_color
    fi

    if [[ "$CONFIGURE_PAPIRUS_FOLDER_THEME" == "true" ]]; then
        configure_vscode_theme
    fi

    if [[ "$CONFIGURE_FLATPAK_THEME" == "true" ]]; then
        configure_flatpak_theme
    fi
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

function configure_papirus_folder_color {

    GNOME_CURRENT_ICON_THEME=$(gsettings get org.gnome.desktop.interface icon-theme)

    if [[ "$GNOME_CURRENT_ICON_THEME" == "'Papirus-Dark'" ]]; then

        echo "Setting papirus icons folder color to 'grey' via 'papirus-folders'..."

        yay -Syu --noconfirm --needed papirus-folders
        papirus-folders -C grey --theme Papirus-Dark
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

    # remove existing flatpak theme (created with pakitheme previously)
    flapack remove -y org.gtk.Gtk3theme.Dracula

    curl -O https://raw.githubusercontent.com/refi64/pakitheme/master/pakitheme
    chmod +x ./pakitheme

    echo "Creating local flatpak GTK theme based on Dracula GTK theme..."

    ./pakitheme install-user
    rm pakitheme
}

function check_args() {
    
    if [[ "$#" -gt 3 ]]; then
        echo -e "${RED}Error: this script can be run with a maximum of three arguments.${NC}"
        echo -e "${LIGHT_BLUE}Usage: "$0" [${ARG_CONFIGURE_PAPIRUS_FOLDER_THEME}] [${ARG_CONFIGURE_VSCODE_THEME}] [${ARG_CONFIGURE_FLATPAK_THEME}]${NC}"
        echo -e "${BLUE}${ARG_CONFIGURE_PAPIRUS_FOLDER_THEME}${NC}  : [optional] configure Papirus folder color to match Dracula theme."
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
