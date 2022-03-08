#!/bin/bash
# recipe.sh : 2022-03-08-15:16:41
# NOTE: Please uncomment the ingredients you wish to install before running!
# --------------------------------------------------------------------------

function main() {
sudo pacman -Syu --noconfirm --needed

# Shell
# --------------------------------------------------------------------------
#./ingredients/shell/fish.sh #Fish shell

# Filesystem
# --------------------------------------------------------------------------
#./ingredients/fs/android-mtp.sh #Android MTP (Media Transfer Protocol) Filesystem

# System
# --------------------------------------------------------------------------
#./ingredients/system/btop.sh #btop: a terminal based system monitoring tool (like htop but better)
#./ingredients/system/seahorse.sh #GUI application for managing Gnome keyring

# Editors
# --------------------------------------------------------------------------
#./ingredients/editor/neovim.sh #Neovim (replaces vim)

# Development
# --------------------------------------------------------------------------
#./ingredients/dev/0_git.sh "Firstname Lastname" "myname@mydomain.com" #Git installation and configuration
#./ingredients/dev/1_vscode.sh #Visual Studio Code
#./ingredients/dev/android.sh #Android development tools (ADB, etc.)
#./ingredients/dev/dotnet.sh #.NET Core SDK and Runtimes
#./ingredients/dev/git-credential-manager-core.sh #Git Crendential Manager (.NET Core based)
#./ingredients/dev/postman.sh #Postman
#./ingredients/dev/vscode-dracula-theme.sh #Dracula theme for VSCode [Requires /dev/1_vscode ingredient]
#./ingredients/dev/vscode-fonts-jetbrains-mono.sh #JetBrains Mono font for Visual Studio Code [Requires /dev/vscode and /fonts/fonts ingredients]
#./ingredients/dev/vscode-vim.sh #vim extension for VSCode [Requires /dev/1_vscode ingredient]
#./ingredients/dev/vscode-wayland.sh #Native Wayland Support for VSCode [Requires /dev/1_vscode ingredient]

# Web
# --------------------------------------------------------------------------
#./ingredients/web/firefox.sh #Firefox
#./ingredients/web/firefox-wayland.sh #Native Wayland Support for Firefox [Requires /web/firefox ingredient]
#./ingredients/web/google-chrome.sh #Google Chrome
#./ingredients/web/google-chrome-wayland.sh #Native Wayland Support for Google Chrome [Requires /web/google-chrome ingredient]
#./ingredients/web/remmina.sh #Remmina RDP client
#./ingredients/web/slack.sh #Slack

# Productivity
# --------------------------------------------------------------------------
#./ingredients/productivity/flameshot.sh #Flameshot (screenshot application)
#./ingredients/productivity/obsidian.sh #Excellent markdown based note manager and "second brain"

# Media
# --------------------------------------------------------------------------
#./ingredients/media/codecs.sh #Codecs for Audio, Images, and Video
#./ingredients/media/gpodder.sh #Excellent podcast manager
#./ingredients/media/gstreamer.sh #Additional GStreamer plugins
#./ingredients/media/tauon-music-box.sh #Tauon Music Box
#./ingredients/media/vlc.sh #VLC media player

# Gaming
# --------------------------------------------------------------------------
#./ingredients/gaming/steam.sh steam #Steam gaming platform

# VM
# --------------------------------------------------------------------------
#./ingredients/vm/kvm-qemu-guest.sh #KVM/QEMU guest utilities (only install if running as VM)
#./ingredients/vm/kvm-qemu-host.sh #KVM/QEMU host installation and configuration

# Icons
# --------------------------------------------------------------------------
#./ingredients/icons/0_papirus-icons.sh #Papirus icon theme
#./ingredients/icons/papirus-icons-folders.sh indigo #Supplmental colored folders for Papirus icon theme [Requires /icons/papirus-icons ingredient]
# Folder colors: black, bluegrey, brown, deeporange, grey, magenta, orange, paleorange, red, violet, yaru, blue, breeze, cyan, green, indigo, nordic, palebrown, pink, teal, white, yellow

# Fonts
# --------------------------------------------------------------------------
#./ingredients/fonts/gnome-fonts.sh #Install and configure sane fonts for Gnome

# Theming
# --------------------------------------------------------------------------
#./ingredients/theme/gnome-terminal-dracula-theme.sh #Dracula theme for Gnome Terminal

# Gnome Extensions
# --------------------------------------------------------------------------
#./ingredients/gnome-ext/appindicator.sh #AppIndicator/KStatusNotifierItem support for Gnome Shell
#./ingredients/gnome-ext/pop-shell.sh #pop-shell gnome extension to add tiling window support to gnome
# Note: pop-shell looks way better with the pop-gtk-theme, so this will be installed and configured as well

# Hardware
# --------------------------------------------------------------------------
#./ingredients/hardware/amd-cpu_undervolt-support.sh #Support for undervolting AMD CPUs [Requires additional configuration]
#./ingredients/hardware/logitec-mouse_solaar.sh #GUI application for managing logitec unifying receivers

# Additional Packages
# --------------------------------------------------------------------------
# paru -S --noconfirm --needed {package1} {package2} ...

}

main "$@"
