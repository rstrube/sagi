#!/bin/bash
# Dev - vscode

DIR=$(dirname "$0")
source $DIR/../_helper/_common-functions.sh

sudo pacman -Syu --noconfirm --needed code

create_empty_vscode_settings_if_neccessary