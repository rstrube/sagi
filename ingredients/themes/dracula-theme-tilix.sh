#!/bin/bash
#|#./ingredients/themes/dracula-theme-tilix.sh #Dracula theme for tilix terminal

DIR=$(dirname "$0")
source $DIR/../_helper/_common-functions.sh

function main() {

    install
}

function install() {

    mkdir -p ~/.config/tilix/schemes
    configure_tilix_dracula_colors
}

function configure_tilix_dracula_colors {

    # See: https://draculatheme.com/contribute

    # Palette Order
    # =============
    # { Term Color} / { Dracula Equivalent }
    # Black / Background
    # Red / Red
    # Green / Green
    # Yellow / Yellow
    # Blue / Purple
    # Magenta / Pink
    # Cyan / Cyan
    # White / Foreground
    # ==================
    # B-Black / Current Line
    # B-Red / B-Red
    # B-Green / B-Green
    # B-Yellow / B-Yellow
    # B-Blue / B-Purple
    # B-Magenta / B-Pink
    # B-Cyan / B-Cyan
    # B-White / Foreground

    cat <<EOT > "Dracula.json"
{
  "background-color": "#282A36",
  "badge-color": "#F8F8F2",
  "bold-color": "#BD93F9",
  "comment": "",
  "cursor-background-color": "#282A36",
  "cursor-foreground-color": "#F8F8F2",
  "foreground-color": "#F8F8F2",
  "highlight-background-color": "#44475A",
  "highlight-foreground-color": "#F8F8F2",
  "name": "Dracula",
  "palette": [
    "#282A36",
    "#FF5555",
    "#50FA7B",
    "#F1FA8C",
    "#BD93F9",
    "#FF79C6",
    "#8BE9FD",
    "#F8F8F2",
    "#44475A",
    "#FF6E67",
    "#5AF78D",
    "#F4F99D",
    "#CAA8FA",
    "#FF92D0",
    "#9AEDFE",
    "#F8F8F2"
  ],
  "use-badge-color": false,
  "use-bold-color": false,
  "use-cursor-color": false,
  "use-highlight-color": false,
  "use-theme-colors": false
}
EOT

    cp Dracula.json ~/.config/tilix/schemes/.
    rm Dracula.json
}

main "$@"
