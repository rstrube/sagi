#!/bin/bash
#|#./ingredients/themes/dracula-theme-kitty.sh #Dracula theme for kitty terminal emulator

cat <<EOT > "dracula-colors.conf"
# vim:ft=kitty
## name: Dracula
## author: Keegan Carruthers-Smith
## license: MIT
## upstream: https://raw.githubusercontent.com/dracula/kitty/master/dracula.conf

foreground            #f8f8f2
background            #282a36
selection_foreground  #ffffff
selection_background  #44475a
url_color #8be9fd
color0  #21222c
color8  #6272a4
color1  #ff5555
color9  #ff6e6e
color2  #50fa7b
color10 #69ff94
color3  #f1fa8c
color11 #ffffa5
color4  #bd93f9
color12 #d6acff
color5  #ff79c6
color13 #ff92df
color6  #8be9fd
color14 #a4ffff
color7  #f8f8f2
color15 #ffffff
cursor            #f8f8f2
cursor_text_color background
active_tab_foreground   #282a36
active_tab_background   #f8f8f2
inactive_tab_foreground #282a36
inactive_tab_background #6272a4
mark1_foreground #282a36
mark1_background #ff5555
EOT

cp dracula-colors.conf ~/.config/kitty/.
rm dracula-colors.conf

echo "# BEGIN_KITTY_THEME" >> ~/.config/kitty/kitty.conf
echo "# Dracula Theme" >> ~/.config/kitty/kitty.conf
echo "include dracula-colors.conf" >> ~/.config/kitty/kitty.conf
echo "# END_KITTY_THEME" >> ~/.config/kitty/kitty.conf
