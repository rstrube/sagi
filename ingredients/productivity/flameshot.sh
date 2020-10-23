#!/bin/bash
# Productivity - Flameshot

DIR=$(dirname "$0")
source $DIR/../_helper/_common-functions.sh

sudo pacman -Syu --noconfirm --needed flameshot
