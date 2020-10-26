#!/bin/bash

#|# Flameshot (screenshot application)
#|#./ingredients/productivity/flameshot.sh

DIR=$(dirname "$0")
source $DIR/../_helper/_common-functions.sh

sudo pacman -Syu --noconfirm --needed flameshot
