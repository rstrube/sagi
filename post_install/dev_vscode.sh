#!/bin/bash
# Dev - vscode

source helper/_common-functions.sh

sudo pacman -Syu --noconfirm --needed code

create_empty_vscode_settings_if_neccessary