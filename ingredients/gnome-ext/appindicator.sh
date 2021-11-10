#!/bin/bash
#|#./ingredients/gnome-ext/appindicator.sh #AppIndicator/KStatusNotifierItem support for Gnome Shell

DIR=$(dirname "$0")
source $DIR/../_helper/_common-functions.sh

paru -S --noconfirm --needed gnome-shell-extension-appindicator-git

echo "After restarting gnome, you can enable the appindicator extension."
echo "You can enable the extension via the Extensions app, or via terminal:"
echo -e "${LBLUE}gnome-extensions enable appindicatorsupport@rgcjonas.gmail.com${NC}"