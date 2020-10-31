#!/bin/bash
# Common Helper Functions

# Console Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
LIGHT_BLUE='\033[1;34m'
NC='\033[0m'

ERROR_VARS_MESSAGE="${RED}Error: invalid argument value passed in.${NC}"

function check_variables_value() {
    NAME=$1
    VALUE=$2
    if [[ -z "$VALUE" ]]; then
        echo -e ${ERROR_VARS_MESSAGE}
        echo "${NAME} must have a value."
        exit 1
    fi
}

function check_variables_boolean() {
    NAME=$1
    VALUE=$2
    case $VALUE in
        true )
            ;;
        false )
            ;;
        * )
            echo -e ${ERROR_VARS_MESSAGE}
            echo "${NAME} must be {true|false}."
            exit 1
            ;;
    esac
}

function check_flatpak_prereq() {

    if [[ ! -e /usr/bin/flatpak ]]; then
        echo -e "${RED}Error: flatpak must be installed.${NC}"
        exit 1
    fi
}

VSCODE_SETTINGS_DIR_PATH="${HOME}/.config/Code - OSS/User"
VSCODE_SETTINGS_FILE_PATH="${VSCODE_SETTINGS_DIR_PATH}/settings.json"

function create_empty_vscode_settings_if_neccessary {

    if [[ ! -d "$VSCODE_SETTINGS_DIR_PATH" ]]; then
        mkdir -p "$VSCODE_SETTINGS_DIR_PATH"
    fi

    if [[ ! -e "$VSCODE_SETTINGS_FILE_PATH" ]]; then
        echo "Creating an empty VSCode settings.json file..."

        echo "{" > "$VSCODE_SETTINGS_FILE_PATH"
        echo "}" >> "$VSCODE_SETTINGS_FILE_PATH"
    fi
}

function print_help_if_neccessary() {

    if [[ "$1" == "--help" ]]; then
        print_help
        exit 0
    fi
}