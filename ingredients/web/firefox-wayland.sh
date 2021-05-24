#!/bin/bash
#|#./ingredients/web/firefox-wayland.sh #Native Wayland Support for Firefox [Requires /web/firefox ingredient]

# Copy the system .desktop file to your $HOME and tweak it to launch Firefox as a native Wayland application
cp /usr/share/applications/firefox.desktop ${HOME}/.local/share/applications/.
sed -i 's/Exec=/&env MOZ_ENABLE_WAYLAND=1 /' ${HOME}/.local/share/applications/firefox.desktop
