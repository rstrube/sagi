#!/bin/bash
# Core - Reflector

DIR=$(dirname "$0")
source $DIR/helper/_common-functions.sh

sudo pacman -Syu --noconfirm --needed reflector
