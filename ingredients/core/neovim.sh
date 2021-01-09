#!/bin/bash
#|#./ingredients/core/neovim #Neovim (replaces vim)

sudo pacman -Rns --noconfirm vim
sudo pacman -Syu --noconfirm --needed neovim
