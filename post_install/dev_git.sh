#!/bin/bash
# Dev - git

source _common-functions.sh

GIT_USERNAME=""
GIT_EMAIL=""
GIT_INSTALL_CREDENTIAL_MANAGER="false"
ARG_GIT_INSTALL_CREDENTIAL_MANAGER="--install-git-credential-manager"

function main() {
    
    check_args "$@"

    if [[ "$#" -ge 2 ]]; then
        GIT_USERNAME="$1"
        GIT_EMAIL="$2"
    fi

    if [[ "$3" == "$ARG_GIT_INSTALL_CREDENTIAL_MANAGER" ]]; then
        GIT_INSTALL_CREDENTIAL_MANAGER="$3"
    fi

    check_variables
    check_critical_prereqs
    install
}

function install() {

    sudo pacman -Syu --noconfirm --needed git
    
    # Set git configuration
    git config --global user.name $GIT_USERNAME
    git config --global user.email $GIT_EMAIL

    if [[ "$GIT_INSTALL_CREDENTIAL_MANAGER" == "true" ]]; then
        echo "Installing git-credential-manager..."
        yay -Syu --noconfirm --needed git-credential-manager-bin
    fi
}

function check_args() {
    
    if [[ "$#" -ne 2 && "$#" -ne 3 ]]; then
        echo -e "${RED}Error: this script can only be run with two or three arguments.${NC}"
        echo ""
        echo -e "${LIGHT_BLUE}Usage:   "$0" {\"full name\"} {email} [${ARG_GIT_INSTALL_CREDENTIAL_MANAGER}]${NC}"
        echo -e "${BLUE}${ARG_GIT_INSTALL_CREDENTIAL_MANAGER}${NC}: [optional] installs git-credential-manager to better handle connecting to Azure DevOps."
        exit 1
    fi
}

function check_variables() {

    check_variables_value "GIT_USERNAME" "$GIT_USERNAME"
    check_variables_value "GIT_EMAIL" "$GIT_EMAIL"
    check_variables_boolean "GIT_INSTALL_CREDENTIAL_MANAGER" "$GIT_INSTALL_CREDENTIAL_MANAGER"
}

function check_critical_prereqs() {

    if [[ "$GIT_INSTALL_CREDENTIAL_MANAGER" == "true" ]]; then
        check_yay_prereq
    fi
}

main "$@"
