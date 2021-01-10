#!/bin/bash
#|./ingredients/core/mandatory.sh #Mandatory programs & utilities

sudo pacman -Syu --noconfirm --needed reflector

CWD=$(pwd)

git clone https://aur.archlinux.org/yay.git /tmp/yay
cd /tmp/yay
makepkg -si

cd ${CWD}
rm -rf /tmp/yay
