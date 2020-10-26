#!/bin/bash

#|# Chromium
#|#./ingredients/web/chromium-1.sh

DIR=$(dirname "$0")
source $DIR/../_helper/_common-functions.sh

sudo pacman -Syu --noconfirm --needed chromium
