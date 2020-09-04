#!/bin/bash
# Core - Yay

DIR=$(dirname "$0")
source $DIR/helper/_common-functions.sh

CWD=$(pwd)

git clone https://aur.archlinux.org/yay.git /tmp/yay
cd /tmp/yay
makepkg -si

cd ${CWD}
rm -rf /tmp/yay
