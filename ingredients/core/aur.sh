#!/bin/bash
#|./ingredients/core/aur.sh #Mandatory AUR helper

sudo pacman -Syu --noconfirm --needed rust

CWD=$(pwd)

git clone https://aur.archlinux.org/paru.git /tmp/paru
cd /tmp/paru
makepkg -si --noconfirm --needed

cd ${CWD}
rm -rf /tmp/paru
