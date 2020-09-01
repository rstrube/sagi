#!/bin/bash
# Web - Chromium

# Enable VAAPI support for Chromium?
CHROMIUM_ENABLE_VAAPI="false"

source _sh-functions.sh

function main() {
    
    check_args $@

    if [[ "$#" -eq 1 ]]; then
        CHROMIUM_ENABLE_VAAPI="$1"
    fi

    check_variables
    install
}

function install() {

    if [[ ! -e /usr/bin/chromium ]]; then
        echo "Installing chromium..."
        pacman -Syu chromium
    fi

    if [[ "$CHROMIUM_ENABLE_VAAPI" != "true" ]]; then
        echo "Skipping additional steps to enable VAAPI..."

        if [[ -e ~/.config/chromium-flags.conf ]]; then
            echo -e "${YELLOW}Warning: there is an existing ~/.config/chromium-flags.conf file. You might need to delete this file to disable VAAPI.${NC}"
        fi

        exit
    fi

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

}

function check_args() {
    
    if [[ "$#" -ne 0 && "$#" -ne 1 ]]; then
        echo -e "${RED}Error: this script must be with either 0 arguments or 1 argument.${NC}"
        echo -e "${LIGHT_BLUE}Usage:   "$0" [{true|false} (enable VAAPI? defaults to false)]"
        echo -e "${BLUE}Example: "$0" true${NC} : installs chromium with VAAPI support."
        echo -e "${BLUE}Example: "$0" false${NC} : installs chromium without VAAPI support."
        echo -e "${BLUE}Example: "$0"${NC} : installs chromium without VAAPI support."
        exit 1
    fi
}

function check_variables() {

    check_variables_boolean "CHROMIUM_ENABLE_VAAPI" "$CHROMIUM_ENABLE_VAAPI"
}

main $@
