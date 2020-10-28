#!/bin/bash

#|# Zsh + Oh-my-Zsh (recommended)
#|./ingredients/core/zsh.sh

DIR=$(dirname "$0")
source $DIR/../_helper/_common-functions.sh

# Oh-My-Zsh requires powerline symbols and therefore powerline patched fonts
yay -Syu --noconfirm --needed zsh powerline-fonts-git

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Agnoster theme is the bees knees
sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="agnoster"/' ~/.zshrc

cp ~/.zshrc .

# Set some very useful aliases
cat <<EOT >> ".zshrc"

# Core aliases
alias sudo="sudo "
alias ls='ls --color=auto'
alias ll='ls -la --color=auto'
alias l.='ls -d .* --color=auto'
alias grep='grep --color'

# Pacman aliases
alias pacman_refresh_mirrors='reflector --verbose --latest 10 --sort rate --save /etc/pacman.d/mirrorlist'
alias pacman_remove_orphans='pacman -Rns $(pacman -Qdtq); yay -Yc'
alias pacman_omni_update='yay -Syu; flatpak update'

EOT

cp .zshrc ~/.zshrc
rm .zshrc

# Change our shell to zsh
chsh -s /usr/bin/zsh
