#!/bin/bash
# Core - Utils

#|./ingredients/core/utils.sh # Core utilities

DIR=$(dirname "$0")
source $DIR/../_helper/_common-functions.sh

sudo pacman -Syu --noconfirm --needed rsync wget reflector