#!/bin/bash
# recipe.sh : 2021-11-05-13:24:09
# NOTE: Please uncomment the ingredients you wish to install before running!
# --------------------------------------------------------------------------

function main() {

# Core
# --------------------------------------------------------------------------
./ingredients/core/aur.sh #Mandatory AUR helper

# Filesystem
# --------------------------------------------------------------------------
#./ingredients/fs/android-mtp.sh #Android MTP (Media Transfer Protocol) Filesystem

# Editors
# --------------------------------------------------------------------------
#./ingredients/editor/neovim.sh #Neovim (replaces vim)

# Development
# --------------------------------------------------------------------------
#./ingredients/dev/0_git.sh "Firstname Lastname" "myname@mydomain.com" #Git installation and configuration
#./ingredients/dev/android.sh #Android development tools (ADB, etc.)
#./ingredients/dev/dotnet.sh #.NET Core SDK and Runtimes
#./ingredients/dev/git-credential-manager-core.sh #Git Crendential Manager (.NET Core based)
#./ingredients/dev/postman.sh #Postman
#./ingredients/dev/vscode.sh #Visual Studio Code
#./ingredients/dev/vscode-vim.sh #vim extension for Visual Studio Code [Requires /dev/vscode ingredient]
#./ingredients/dev/vscode-wayland.sh #Native Wayland Support for VSCode [Requires /dev/vscode ingredient]

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

# Media
# --------------------------------------------------------------------------
#./ingredients/media/codecs.sh #Codecs for Audio, Images, and Video
#./ingredients/media/gstreamer.sh #Additional GStreamer plugins
#./ingredients/media/pulseeffects.sh #PulseEffects + Perfect EQ
#./ingredients/media/tauon-music-box.sh #Tauon Music Box
#./ingredients/media/vlc.sh #VLC media player

# Gaming
# --------------------------------------------------------------------------
#./ingredients/gaming/steam.sh steam #Steam gaming platform

# Hardware
# --------------------------------------------------------------------------
#./ingredients/hardware/cpu-generic_cpupower-gui.sh #GUI utility to set CPU govenor settings
#./ingredients/hardware/cpu-intel_undervolt-support.sh #Utilities neccessary to undervolt Intel CPUs
#./ingredients/hardware/logitec-mouse_solaar.sh #GUI application for managing logitec unifying receivers

# System Monitoring
# --------------------------------------------------------------------------
#./ingredients/system-monitor/btop.sh #btop: a terminal based system monitoring tool (like htop but better)

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
#./ingredients/fonts/enhanced-fonts.sh #Install and configure fonts: Font Awesome, Roboto, FiraCode, JetBrains Mono, Liberation Fonts
#./ingredients/fonts/jetbrains-mono-vscode.sh #JetBrains Mono font for Visual Studio Code [Requires /dev/vscode and /fonts/enhanced-fonts ingredients]

# Themes
# --------------------------------------------------------------------------
#./ingredients/themes/dracula-gedit.sh #Dracula theme for gedit
#./ingredients/themes/dracula-gnome-terminal.sh #Dracula theme for Gnome Terminal
#./ingredients/themes/dracula-gtk.sh #Dracula theme for GTK
#./ingredients/themes/dracula-vscode.sh #Dracula theme for VSCode [Requires /dev/vscode ingredient]

# Gnome Extensions
# --------------------------------------------------------------------------
#./ingredients/gnome-ext/tray-icons.sh #Tray Icons Reloaded Gnome Extension https://github.com/MartinPL/Tray-Icons-Reloaded

# Additional Packages
# --------------------------------------------------------------------------
# paru -S --noconfirm --needed {package1} {package2} ...

}

main "$@"
