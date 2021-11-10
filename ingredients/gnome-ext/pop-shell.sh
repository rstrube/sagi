#!/bin/bash
#|#./ingredients/gnome-ext/pop-shell.sh #pop-shell gnome extension to add tiling window support to gnome
#|# Note: pop-shell looks way better with the pop-gtk-theme, so this will be installed and configured as well

DIR=$(dirname "$0")
source $DIR/../_helper/_common-functions.sh

# Install pop-gtk-theme and pop-shell
paru -S --noconfirm --needed pop-gtk-theme-git gnome-shell-extension-pop-shell-git

# Fix an issue with symbolic links that prevents 'Pop-dark' from being made available as a gnome shell theme
sudo ln -s /usr/share/gnome-shell/theme/Pop-dark /usr/share/themes/Pop-dark/gnome-shell

# Enable the gnome 'user-theme' extension (comes with 'gnome-shell-extensions' package)
# Note: you can get a list of gnome extensions in /usr/share/gnome-shell/extensions
gnome-extensions enable user-theme@gnome-shell-extensions.gcampax.github.com

# Set the gnome-shell theme, gtk theme, and wm theme to 'Pop-dark'
# Note you can use gsettings list-keys org.gnome.xxx.xxx to get a list of keys that can be retrieved/set under a schema
gsettings set org.gnome.shell.extensions.user-theme name "Pop-dark"
gsettings set org.gnome.desktop.interface gtk-theme "Pop-dark"
gsettings set org.gnome.desktop.wm.preferences theme "Pop-dark"

# Update global keybindings
echo "Updating gnome global key bindings to properly support pop-shell shortcuts..."

left="h"
down="j"
up="k"
right="l"

KEYS_GNOME_WM=/org/gnome/desktop/wm/keybindings
KEYS_GNOME_SHELL=/org/gnome/shell/keybindings
KEYS_MUTTER=/org/gnome/mutter/keybindings
KEYS_MEDIA=/org/gnome/settings-daemon/plugins/media-keys
KEYS_MUTTER_WAYLAND_RESTORE=/org/gnome/mutter/wayland/keybindings/restore-shortcuts

# Disable incompatible shortcuts
# Restore the keyboard shortcuts: disable <Super>Escape
dconf write ${KEYS_MUTTER_WAYLAND_RESTORE} "@as []"
# Hide window: disable <Super>h
dconf write ${KEYS_GNOME_WM}/minimize "@as ['<Super>comma']"
# Open the application menu: disable <Super>m
dconf write ${KEYS_GNOME_SHELL}/open-application-menu "@as []"
# Toggle message tray: disable <Super>m
dconf write ${KEYS_GNOME_SHELL}/toggle-message-tray "@as ['<Super>v']"
# Show the activities overview: disable <Super>s
dconf write ${KEYS_GNOME_SHELL}/toggle-overview "@as []"
# Switch to workspace left: disable <Super>Left
dconf write ${KEYS_GNOME_WM}/switch-to-workspace-left "@as []"
# Switch to workspace right: disable <Super>Right
dconf write ${KEYS_GNOME_WM}/switch-to-workspace-right "@as []"
# Maximize window: disable <Super>Up
dconf write ${KEYS_GNOME_WM}/maximize "@as []"
# Restore window: disable <Super>Down
dconf write ${KEYS_GNOME_WM}/unmaximize "@as []"
# Move to monitor up: disable <Super><Shift>Up
dconf write ${KEYS_GNOME_WM}/move-to-monitor-up "@as []"
# Move to monitor down: disable <Super><Shift>Down
dconf write ${KEYS_GNOME_WM}/move-to-monitor-down "@as []"

# Super + direction keys, move window left and right monitors, or up and down workspaces
# Move window one monitor to the left
dconf write ${KEYS_GNOME_WM}/move-to-monitor-left "@as []"
# Move window one workspace down
dconf write ${KEYS_GNOME_WM}/move-to-workspace-down "@as []"
# Move window one workspace up
dconf write ${KEYS_GNOME_WM}/move-to-workspace-up "@as []"
# Move window one monitor to the right
dconf write ${KEYS_GNOME_WM}/move-to-monitor-right "@as []"

# Super + Ctrl + direction keys, change workspaces, move focus between monitors
# Move to workspace below
dconf write ${KEYS_GNOME_WM}/switch-to-workspace-down "['<Primary><Super>Down','<Primary><Super>${down}']"
# Move to workspace above
dconf write ${KEYS_GNOME_WM}/switch-to-workspace-up "['<Primary><Super>Up','<Primary><Super>${up}']"

# Disable tiling to left / right of screen
dconf write ${KEYS_MUTTER}/toggle-tiled-left "@as []"
dconf write ${KEYS_MUTTER}/toggle-tiled-right "@as []"

# Toggle maximization state
dconf write ${KEYS_GNOME_WM}/toggle-maximized "['<Super>m']"
# Lock screen
dconf write ${KEYS_MEDIA}/screensaver "['<Super>Escape']"
# Home folder
dconf write ${KEYS_MEDIA}/home "['<Super>f']"
# Launch email client
dconf write ${KEYS_MEDIA}/email "['<Super>e']"
# Launch web browser
dconf write ${KEYS_MEDIA}/www "['<Super>b']"
# Launch terminal
dconf write ${KEYS_MEDIA}/terminal "['<Super>t']"
# Rotate Video Lock
dconf write ${KEYS_MEDIA}/rotate-video-lock-static "@as []"

# Close Window
dconf write ${KEYS_GNOME_WM}/close "['<Super>q', '<Alt>F4']"

echo "After restarting gnome, you can enable the pop-shell extension."
echo "You can enable the extension via the Extensions app, or via terminal:"
echo -e "${LBLUE}gnome-extensions enable pop-shell@system76.com${NC}"
