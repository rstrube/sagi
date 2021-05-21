#!/bin/bash
#|#./ingredients/icons/papirus-icons-folders.sh indigo #Supplmental colored folders for Papirus icon theme [Requires /icons/papirus-icons ingredient]
#|# Folder colors: black, bluegrey, brown, deeporange, grey, magenta, orange, paleorange, red, violet, yaru, blue, breeze, cyan, green, indigo, nordic, palebrown, pink, teal, white, yellow

# Please see https://github.com/PapirusDevelopmentTeam/papirus-folders for a galley of all the folder colors that are available

DIR=$(dirname "$0")
source $DIR/../_helper/_common-functions.sh

FOLDER_COLOR=""

function main() {
    
    check_args "$@"

    if [[ "$#" -eq 1 ]]; then
        FOLDER_COLOR="$1"
    fi

    check_variables
    install
}

function install() {

    GNOME_CURRENT_ICON_THEME=$(gsettings get org.gnome.desktop.interface icon-theme)

    if [[ "$GNOME_CURRENT_ICON_THEME" == "'Papirus-Dark'" ]]; then

        echo "Setting papirus icons folder color to '$FOLDER_COLOR' via 'papirus-folders'..."

        paru -S --noconfirm --needed papirus-folders
        papirus-folders -C $FOLDER_COLOR --theme Papirus-Dark
    fi
}

function check_args() {
    
    print_help_if_neccessary "$@"

    if [[ "$#" -ne 1 ]]; then
        echo -e "${RED}Error: this script must be run with one arguments.${NC}"
        echo ""
        print_help
        exit 1
    fi
}

function print_help() {

    echo -e "${LBLUE}Usage: "$0" {folder color}${NC}"
}

function check_variables() {

    check_variables_value "FOLDER_COLOR" "$FOLDER_COLOR"
}

main "$@"
