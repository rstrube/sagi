#!/bin/bash

#|# Steam gaming platform
#|#./ingredients/gaming/steam.sh

DIR=$(dirname "$0")
source $DIR/../_helper/_common-functions.sh

sudo pacman -Syu --noconfirm --needed steam
