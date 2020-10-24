#!/bin/bash
# Dev - vscode

#|#./ingredients/dev/vscode.sh # Visual Studio Code (OSS Version): Incredible open source IDE

DIR=$(dirname "$0")
source $DIR/../_helper/_common-functions.sh

sudo pacman -Syu --noconfirm --needed code

create_empty_vscode_settings_if_neccessary