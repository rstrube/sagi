#!/bin/bash
# Web - Chromium

# Enable VAAPI support for Chromium?
ENABLE_CHROMIUM_VAAPI="true"

source _common-sh-functions.sh

function main() {
    
    check_variables
    install
}

function install() {

    if [[ ! -e /usr/bin/chromium ]]; then
        yay -S --noconfirm chromium
    fi

    if [ "$ENABLE_CHROMIUM_VAAPI" != "true" ]; then
        exit
    fi

    # Generate ~/.config/chromium-flags.conf to enable VAAPI support
    echo "Enabling Chromium VAAPI support..."
    echo "Generating ~/.config/chromium-flags.conf file..."

    cat <<EOT > "~/.config/chromium-flags.conf"
--ignore-gpu-blacklist
--enable-gpu-rasterization
--enable-zero-copy
EOT

}

function check_variables() {

    check_variables_boolean "ENABLE_CHROMIUM_VAAPI" "$ENABLE_CHROMIUM_VAAPI"
}

function check_critical_prereqs() {
    check_yay_prereq
}

main $@