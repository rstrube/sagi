#!/bin/bash
#|#./ingredients/themes/gnome-dracula-theme-gnome-terminal.sh #Dracula theme for Gnome Terminal

# Please refer to https://draculatheme.com/contribute/ for a full list of hex codes

# Reset gnome-terminal
dconf reset -f /org/gnome/terminal/

# Make sure terminal uses the dark theme
gsettings set org.gnome.Terminal.Legacy.Settings theme-variant 'dark'

GT_DCONF_DIR=/org/gnome/terminal/legacy/profiles:
GT_PROFILE_ID="$(uuidgen)"
GT_DCONF_PROFILE_DIR="${GT_DCONF_DIR}/:$GT_PROFILE_ID"

GT_PROFILE_NAME="'Dracula'"
GT_PROFILE_BACKGROUND_COLOR="'#282A36'"
GT_PROFILE_BOLD_COLOR="'#BD93F9'"
GT_PROFILE_FOREGROUND_COLOR="'#F8F8F2'"

# Term Colors		 Black		B-Red	   B-Green	  B-Yellow	 B-Blue		B-Magenta  B-Cyan	  B-White	 B-Black	Red		   Green	  Yellow	 Blue		Magenta	   Cyan		  White																
# Eq Dracula Colors  Background B-Pink     B-Green    B-Yellow   B-Purple   B-Red      B-Cyan     B-Orange   Curr Line  Pink       Green      Yellow     Purple     Red        Cyan       Orange
GT_PROFILE_PALLETE="['#282A36', '#FF79C6', '#50FA7B', '#F1FA8C', '#BD93F9', '#FF5555', '#8BE9FD', '#FFB86C', '#44475A', '#FF79C6', '#50FA7B', '#F1FA8C', '#BD93F9', '#FF5555', '#8BE9FD', '#FFB86C']"

dconf write ${GT_DCONF_DIR}/default "'$GT_PROFILE_ID'"
dconf write ${GT_DCONF_DIR}/list "['$GT_PROFILE_ID']"

dconf write ${GT_DCONF_PROFILE_DIR}/background-color $GT_PROFILE_BACKGROUND_COLOR
dconf write ${GT_DCONF_PROFILE_DIR}/bold-color $GT_PROFILE_BOLD_COLOR
dconf write ${GT_DCONF_PROFILE_DIR}/bold-color-same-as-fg "false"
dconf write ${GT_DCONF_PROFILE_DIR}/foreground-color $GT_PROFILE_FOREGROUND_COLOR
dconf write ${GT_DCONF_PROFILE_DIR}/palette "$GT_PROFILE_PALLETE"
dconf write ${GT_DCONF_PROFILE_DIR}/use-theme-colors "false"
dconf write ${GT_DCONF_PROFILE_DIR}/visible-name $GT_PROFILE_NAME
