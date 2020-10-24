#!/bin/bash
# Productivity - Flameshot

#|#./ingredients/productivity/flameshot.sh # Flameshot: Incredible screenshot application

DIR=$(dirname "$0")
source $DIR/../_helper/_common-functions.sh

sudo pacman -Syu --noconfirm --needed flameshot
