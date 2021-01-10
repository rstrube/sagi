#!/bin/bash
#|#install-pkg git #Git installation and configuration
#|#git config --global user.name "First Last"
#|#git config --global user.email "myname@mydomain.com"

DIR=$(dirname "$0")
source $DIR/../_helper/_common-functions.sh

GIT_USERNAME=""
GIT_EMAIL=""

function main() {
    
    check_args "$@"

    if [[ "$#" -eq 2 ]]; then
        GIT_USERNAME="$1"
        GIT_EMAIL="$2"
    fi

    check_variables
    install
}

function install() {

    sudo pacman -Syu --noconfirm --needed git
    
    # Set git configuration
    git config --global user.name $GIT_USERNAME
    git config --global user.email $GIT_EMAIL
}

function check_args() {
    
    print_help_if_neccessary "$@"

    if [[ "$#" -ne 2 ]]; then
        echo -e "${RED}Error: this script must be run with two arguments.${NC}"
        echo ""
        print_help
        exit 1
    fi
}

function print_help() {

    echo -e "${LBLUE}Usage: "$0" {\"full name\"} {email}${NC}"
}

function check_variables() {

    check_variables_value "GIT_USERNAME" "$GIT_USERNAME"
    check_variables_value "GIT_EMAIL" "$GIT_EMAIL"
}

main "$@"
