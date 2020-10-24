#!/bin/bash
# Core - Yay

#|./ingredients/core/yay.sh # Yay: let's you easily install packages for AUR

DIR=$(dirname "$0")
source $DIR/../_helper/_common-functions.sh

CWD=$(pwd)

git clone https://aur.archlinux.org/yay.git /tmp/yay
cd /tmp/yay
makepkg -si

cd ${CWD}
rm -rf /tmp/yay
