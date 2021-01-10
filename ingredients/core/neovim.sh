#!/bin/bash
#|#./ingredients/core/neovim.sh #Neovim (replaces vim)

sudo pacman -Rns --noconfirm vim
sudo pacman -Syu --noconfirm --needed neovim
sudo ln -s /usr/bin/nvim /usr/bin/vim
