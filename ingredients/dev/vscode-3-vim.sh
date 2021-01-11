#!/bin/bash
#|#./ingredients/dev/vscode-3-vim.sh #VSCode vim extension

DIR=$(dirname "$0")
source $DIR/../_helper/_vscode-functions.sh

create_empty_vscode_settings_if_neccessary
code --install-extension vscodevim.vim
