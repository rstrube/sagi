#!/bin/bash
# Core - Zsh

source _common-functions.sh

# Oh-My-Zsh requires powerline symbols and therefore powerline patched fonts
yay -Syu --noconfirm --needed zsh powerline-fonts-git

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Agnoster theme is the bees knees
sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="agnoster"/' ~/.zshrc

cp ~/.zshrc .

# Set some very useful aliases
cat <<EOT >> ".zshrc"
alias sudo="sudo "
alias vim="nvim"
alias ls='ls --color=auto'
alias ll='ls -la --color=auto'
alias l.='ls -d .* --color=auto'
alias grep='grep --color'
EOT

cp .zshrc ~/.zshrc
rm .zshrc

# Change our shell to zsh
chsh -s /usr/bin/zsh
