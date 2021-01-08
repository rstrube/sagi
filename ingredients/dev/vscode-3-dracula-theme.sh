#!/bin/bash
#|#./ingredients/dev/vscode-3-dracula-theme.sh #VSCode Dracula theme

DIR=$(dirname "$0")
source $DIR/../_helper/_common-functions.sh

create_empty_vscode_settings_if_neccessary
code --install-extension dracula-theme.theme-dracula
sed -i '$i\    "workbench.colorTheme": "Dracula",' "$VSCODE_SETTINGS_FILE_PATH"
