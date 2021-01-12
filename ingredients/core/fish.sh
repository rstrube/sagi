#!/bin/bash
#|#./ingredients/core/fish.sh #Fish shell + Oh my Fish

DIR=$(dirname "$0")
source $DIR/../_helper/_common-functions.sh

paru -Syu --noconfirm --needed fish

curl -O https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install
fish install --noninteractive --yes
rm install

cat <<EOT > "init.fish"	
alias ls="ls --color=auto"
alias ll="ls -la --color=auto"
alias l.="ls -d .* --color=auto"
alias grep="grep --color"

alias pacman_remove_orphans="paru -c"

function reflector_refresh_mirrors --wraps reflector
    set DATE (date +%Y-%m-%d-%H:%M:%S)
    sudo cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.{$DATE}.bak
    sudo reflector --verbose --country $argv --latest 10 --sort rate --save /etc/pacman.d/mirrorlist
end
EOT

cp init.fish ~/.config/omf/
rm init.fish

# Change the shell to fish
chsh -s /usr/bin/fish

echo -e "${YELLOW}Warning: you will need logout in order for the shell change to take effect.${NC}"