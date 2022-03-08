#!/bin/bash
#|#./ingredients/dev/vscode-wayland.sh #Native Wayland Support for VSCode [Requires /dev/1_vscode ingredient]

DIR=$(dirname "$0")
source $DIR/_helper/_vscode-functions.sh

create_and_configure_code_flags_for_wayland

# Tweak VSCode settings to ensure that a custom titlebar is used.  Without this there will be no titlebar on Gnome + Wayland
sed -i '$i\    "window.titleBarStyle": "custom",' "$VSCODE_SETTINGS_FILE_PATH"
