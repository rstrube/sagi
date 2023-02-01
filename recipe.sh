#!/bin/bash
# recipe.sh : 2023-02-01-11:59:00
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
#./ingredients/system/dnsutils.sh #Various DNS related utilities including dig
#./ingredients/system/kitty.sh #kitty: a lightweight GPU accelerated terminal emulator
#./ingredients/system/networkmanager-openvpn.sh #OpenVPN support for networkmanager
#./ingredients/system/openssh.sh #OpenSSH: supports remote login via SSH protocol
#./ingredients/system/rsync.sh #Command line utility for syncing filesystems (useful for backup)
#./ingredients/system/seahorse.sh #GUI application for managing Gnome keyring

# Editors
# --------------------------------------------------------------------------
#./ingredients/editor/neovim.sh #Neovim (replaces vim)

# Web
# --------------------------------------------------------------------------
#./ingredients/web/firefox.sh #Firefox
#./ingredients/web/firefox-wayland.sh #Native Wayland Support for Firefox [Requires /web/firefox ingredient]
#./ingredients/web/google-chrome.sh #Google Chrome
#./ingredients/web/google-chrome-wayland.sh #Native Wayland Support for Google Chrome [Requires /web/google-chrome ingredient]
#./ingredients/web/remmina.sh #Remmina RDP client
#./ingredients/web/slack.sh #Slack

# Development
# --------------------------------------------------------------------------
#./ingredients/dev/0_git.sh "Firstname Lastname" "myname@mydomain.com" #Git installation and configuration
#./ingredients/dev/1_vscode.sh #Visual Studio Code
#./ingredients/dev/2_gnome-vscode-wayland.sh #Native Wayland Support for VSCode [Requires /dev/1_vscode ingredient]
#./ingredients/dev/3_dotnet-6.sh #.NET Core SDK and Runtimes (version 6.x)
#./ingredients/dev/3_dotnet-latest.sh #.NET Core SDK and Runtimes (latest stable version)
#./ingredients/dev/4_dotnet-https-dev-cert.sh #ASP.NET Dev HTTPS Cert [Requires /dev/dotnet ingredient]
#./ingredients/dev/android.sh #Android development tools (ADB, etc.)
#./ingredients/dev/docker.sh #Docker
#./ingredients/dev/postman.sh #Postman
#./ingredients/dev/vscode-vim.sh #vim extension for VSCode [Requires /dev/1_vscode ingredient]

# Productivity
# --------------------------------------------------------------------------
#./ingredients/productivity/cht.sh #cht.sh is a command line cheatsheet that provides TLDR for tons of things
#./ingredients/productivity/flameshot.sh #Flameshot (screenshot application)
#./ingredients/productivity/obsidian.sh #Excellent markdown based note manager and "second brain"
#./ingredients/productivity/obsidian-wayland.sh #Configure Obsidian to run as a native Wayland application
#./ingredients/productivity/pdftk.sh #PDF Toolkit allows for merging, splitting, etc.
#./ingredients/productivity/teams.sh #Teams for Linux (uses electron wrapper)
#./ingredients/productivity/xournalpp.sh #Xournal++ PDF annotation application

# Media
# --------------------------------------------------------------------------
#./ingredients/media/blanket.sh #Whitenoise generation application
#./ingredients/media/codecs.sh #Codecs for Audio, Images, and Video
#./ingredients/media/dvd.sh #Support for CD & DVD playback [Requires player e.g. vlc]
#./ingredients/media/gpodder.sh #Excellent podcast manager
#./ingredients/media/tauon-music-box.sh #Tauon Music Box
#./ingredients/media/vlc.sh #VLC media player

# Gaming
# --------------------------------------------------------------------------
#./ingredients/gaming/steam.sh #Steam gaming platform

# VM
# --------------------------------------------------------------------------
#./ingredients/vm/kvm-qemu-guest.sh #KVM/QEMU guest utilities (only install if running as VM)
#./ingredients/vm/kvm-qemu-host.sh #KVM/QEMU host installation and configuration

# Icons
# --------------------------------------------------------------------------
#./ingredients/icons/0_gnome-papirus-icons.sh #Papirus icon theme and config for Gnome
#./ingredients/icons/papirus-icons-folders.sh indigo Papirus-Dark #Supplmental colored folders for Papirus icon theme [Requires /icons/0_xxx-papirus-icons ingredient]
# Folder colors: black, bluegrey, brown, deeporange, grey, magenta, orange, paleorange, red, violet, yaru, blue, breeze, cyan, green, indigo, nordic, palebrown, pink, teal, white, yellow

# Fonts
# --------------------------------------------------------------------------
#./ingredients/fonts/0_gnome-fonts.sh #Install and configure sane fonts for Gnome
#./ingredients/fonts/kitty-jetbrains-mono.sh #JetBrains Mono font for Kitty terminal emulator [Requires /system/kitty and /fonts/0_xxx-fonts ingredients]
#./ingredients/fonts/vscode-jetbrains-mono.sh #JetBrains Mono font for Visual Studio Code [Requires /dev/1_vscode and /fonts/0_xxx-fonts ingredients]

# Hardware
# --------------------------------------------------------------------------
#./ingredients/hardware/mouse-logitec-solaar.sh #GUI application for managing logitec unifying receivers

# Theming
# --------------------------------------------------------------------------
#./ingredients/themes/dracula-theme-fish-shell.sh #Dracula theme for fish shell [Requires /shell/fish ingredient]
#./ingredients/themes/dracula-theme-gnome-terminal.sh #Dracula theme for Gnome Terminal
#./ingredients/themes/dracula-theme-kitty.sh #Dracula theme for kitty terminal emulator
#./ingredients/themes/dracula-theme-tilix.sh #Dracula theme for tilix terminal
#./ingredients/themes/dracula-theme-vscode.sh #Dracula theme for VSCode [Requires /dev/1_vscode ingredient]
#./ingredients/themes/gnome-adwaita-dark-legacy-gtk.sh #Set Adwaita-dark as default theme for legacy GTK apps

# Gnome Extensions
# --------------------------------------------------------------------------
#./ingredients/gnome-ext/appindicator.sh #AppIndicator/KStatusNotifierItem support for Gnome Shell

# Additional Packages
# --------------------------------------------------------------------------
# paru -S --noconfirm --needed {package1} {package2} ...

}

main "$@"
