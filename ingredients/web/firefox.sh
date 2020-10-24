#!/bin/bash
# Web - Firefox

#|#./ingredients/web/firefox.sh # Firefox

DIR=$(dirname "$0")
source $DIR/../_helper/_common-functions.sh

sudo pacman -Syu --noconfirm --needed firefox
