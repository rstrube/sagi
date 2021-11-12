#!/bin/bash
#|#./ingredients/fonts/gnome-fonts.sh #Install and configure sane fonts for Gnome

DIR=$(dirname "$0")
source $DIR/_helper/_font-common-functions.sh

install_fonts
setup_local_fontconfig

# Configure Gnome to use newly installed fonts
gsettings set org.gnome.desktop.interface font-name "Roboto 10"
gsettings set org.gnome.desktop.interface document-font-name "Roboto 10"
gsettings set org.gnome.desktop.interface monospace-font-name "JetBrains Mono 11"
gsettings set org.gnome.desktop.wm.preferences titlebar-font "Roboto Medium 10"

test_coverage
