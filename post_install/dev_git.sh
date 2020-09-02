#!/bin/bash
# Dev - git

GIT_USERNAME=""
GIT_EMAIL=""
GIT_INSTALL_CREDENTIAL_MANAGER="false"

source _sh-functions.sh

function main() {
    
    check_args "$@"

    if [[ "$#" -eq 2 || "$#" -eq 3 ]]; then
        GIT_USERNAME="$1"
        GIT_EMAIL="$2"

        if [[ "$#" -eq 3 ]]; then
            GIT_INSTALL_CREDENTIAL_MANAGER="$3"
        fi
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
        echo -e "${RED}Error: this script must be run with 2 or 3 arguments.${NC}"
        echo ""
        echo -e "${LIGHT_BLUE}Usage:   "$0" {Full Name} {Email} [Install Git Crendential Manager? {true|false}]${NC}"
        echo -e "${BLUE}Example: "$0" \"Robert Strube\" robert@mydomain.com${NC} : installs git and configures git global username and email."
        echo -e "${BLUE}Example: "$0" \"Robert Strube\" robert@mydomain.com true${NC} : installs git, configures git global username and email, and installs git-credential-manager."
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
