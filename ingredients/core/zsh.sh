#!/bin/bash
# Core - Zsh

#|./ingredients/core/zsh.sh # Zsh + Oh-my-Zsh: fanstatic shell with built in support for git repos

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
alias sudo="sudo "
alias vim='nvim'
alias ls='ls --color=auto'
alias ll='ls -la --color=auto'
alias l.='ls -d .* --color=auto'
alias grep='grep --color'
alias refresh_pacman_mirrors='reflector --verbose --latest 10 --sort rate --save /etc/pacman.d/mirrorlist'
alias omni_update='sudo pacman -Syu; yay -Syu; flatpak update'
EOT

cp .zshrc ~/.zshrc
rm .zshrc

# Change our shell to zsh
chsh -s /usr/bin/zsh
