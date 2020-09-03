#!/bin/bash
# Web - Chromium

source helper/_common-functions.sh

# Enable VAAPI support for Chromium?
CHROMIUM_ENABLE_VAAPI="false"
ARG_CHROMIUM_ENABLE_VAAPI="--enable-vaapi"

function main() {
    
    check_args "$@"

    if [[ "$1" == "$ARG_CHROMIUM_ENABLE_VAAPI" ]]; then
        CHROMIUM_ENABLE_VAAPI="true"
    fi

    check_variables
    install
}

function install() {

    sudo pacman -Syu --noconfirm --needed chromium

    if [[ "$CHROMIUM_ENABLE_VAAPI" == "true" ]]; then
        
        # Generate ~/.config/chromium-flags.conf to enable VAAPI support
        echo "Enabling Chromium VAAPI support..."
        echo "Generating ~/.config/chromium-flags.conf file..."

        cat <<EOT > "chromium-flags.conf"
--ignore-gpu-blacklist
--enable-gpu-rasterization
--enable-zero-copy
EOT
        mv chromium-flags.conf ~/.config/.

        echo "===~/.config/chromium-flags.conf==="
        cat ~/.config/chromium-flags.conf
        echo "==================================="
    fi
}

function check_args() {
    
    if [[ "$#" -gt 1 ]]; then
        echo -e "${RED}Error: this script can be run with a maximum of one argument.${NC}"
        echo -e "${LIGHT_BLUE}Usage:   "$0" ${ARG_CHROMIUM_ENABLE_VAAPI}${NC}"
        echo -e "${BLUE}${ARG_CHROMIUM_ENABLE_VAAPI}${NC}: [optional] enable VAAPI support"
        exit 1
    fi
}

function check_variables() {

    check_variables_boolean "CHROMIUM_ENABLE_VAAPI" "$CHROMIUM_ENABLE_VAAPI"
}

main "$@"
