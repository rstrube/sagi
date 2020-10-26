#!/bin/bash

#|# Chromium enable VAAPI support (requires Chromium ingredient)
#|#./ingredients/web/chromium-2-enable-vaapi.sh

DIR=$(dirname "$0")
source $DIR/../_helper/_common-functions.sh

function main() {
    
    install
}

function install() {

    # Generate ~/.config/chromium-flags.conf to enable VAAPI support

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

main "$@"
