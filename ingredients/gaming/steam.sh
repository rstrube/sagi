#!/bin/bash
# Gaming - Steam

#|#./ingredients/gaming/steam.sh # Steam: Digital distribution platform for PC games

DIR=$(dirname "$0")
source $DIR/../_helper/_common-functions.sh

sudo pacman -Syu --noconfirm --needed steam
