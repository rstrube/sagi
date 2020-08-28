#!/bin/bash
# Common Helper Functions

# Console Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
LIGHT_BLUE='\033[1;34m'
NC='\033[0m'

ERROR_VARS_MESSAGE="${RED}Error: you must edit this script (e.g. with vim) and configure variables.${NC}"

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

function check_yay_prereq() {

    if [[ ! -e /usr/bin/yay ]]; then
        echo -e "${RED}Error: yay must be installed.${NC}"
        echo "You can install yay by running ./core-yay.sh"
        exit 1
    fi
}