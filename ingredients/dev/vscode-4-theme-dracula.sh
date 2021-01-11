#!/bin/bash
#|#./ingredients/dev/vscode-4-theme-dracula.sh #VSCode Dracula theme extension

DIR=$(dirname "$0")
source $DIR/../_helper/_vscode-functions.sh

create_empty_vscode_settings_if_neccessary
code --install-extension dracula-theme.theme-dracula
sed -i '$i\    "workbench.colorTheme": "Dracula",' "$VSCODE_SETTINGS_FILE_PATH"
