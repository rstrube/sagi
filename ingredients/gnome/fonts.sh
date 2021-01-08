#!/bin/bash
#|#./ingredients/gnome/fonts.sh #Gnome fonts

# Install the following fonts:
# Fira Code: https://github.com/tonsky/FiraCode
# Roboto: default font for Google's Android OS
# Jetbrains Mono: a fantastic monospace font
# Droid: another common font that came with Google's Android OS
yay -Syu --noconfirm --needed ttf-fira-code ttf-roboto ttf-roboto-slab ttf-jetbrains-mono ttf-droid

# This rebuilds the font-cache, taking into account any changes
sudo fc-cache -r -v

# Setup a local fonts.conf to ensure that fallbacks for JetBrains Mono and Fira Code use other monospoce fonts first
# See: https://eev.ee/blog/2015/05/20/i-stared-into-the-fontconfig-and-the-fontconfig-stared-back-at-me/
if [[ ! -d "~/.config/fontconfig" ]]; then
    mkdir -p ~/.config/fontconfig
fi

cat <<EOT > "fonts.conf"
<fontconfig>
    <!-- register JetBrains Mono and Fira Code as monospace fonts -->
    <alias>
        <family>JetBrains Mono</family>
        <default>
            <family>monospace</family>
        </default>
    </alias>
    <alias>
        <family>Fira Code</family>
        <default>
            <family>monospace</family>
        </default>
    </alias>

    <!-- by default fontconfig assumes any unrecognized font is sans-serif, so -->
    <!-- the fonts above now have /both/ families.  fix this. -->
    <!-- note that "delete" applies to the first match -->
    <match>
        <test compare="eq" name="family">
            <string>sans-serif</string>
        </test>
        <test compare="eq" name="family">
            <string>monospace</string>
        </test>
        <edit mode="delete" name="family"/>
    </match>
</fontconfig>
EOT

mv fonts.conf ~/.config/fontconfig/

# Configure Gnome to use newly installed fonts
gsettings set org.gnome.desktop.interface font-name "Roboto 10"
gsettings set org.gnome.desktop.interface document-font-name "Roboto Slab 11"
gsettings set org.gnome.desktop.interface monospace-font-name "JetBrains Mono 11"
gsettings set org.gnome.desktop.wm.preferences titlebar-font "Roboto Medium 10"

# Test font coverage for specific unicode characters required by PowerLine
echo "Testing font coverage..."
echo -e "\ue0b0 \u00b1 \ue0a0 \u27a6 \u2718 \u26a1 \u2699 \u2800 \u28ff \u25a0 \u25ff \u2500 \u259f"
