#!/bin/bash
# recipe.sh : 2021-11-03-21:22:06
# NOTE: Please uncomment the ingredients you wish to install before running!
# --------------------------------------------------------------------------

function main() {

# 1. Core
# --------------------------------------------------------------------------
./ingredients/core/0_mandatory.sh #Mandatory programs & utilities
#./ingredients/core/fs_android-mtp.sh #Android MTP (Media Transfer Protocol) Filesystem
#./ingredients/core/neovim.sh #Neovim (replaces vim)
#./ingredients/core/pipewire.sh #Pipewire (replaces Pulseaudio)
#./ingredients/core/shell_fish.sh #Fish shell
#./ingredients/core/wayland.sh #Wayland utilities

# 2. Development
# --------------------------------------------------------------------------
#./ingredients/dev/0_git.sh "Firstname Lastname" "myname@mydomain.com" #Git installation and configuration
#./ingredients/dev/android.sh #Android development tools (ADB, etc.)
#./ingredients/dev/dotnet.sh #.NET Core SDK and Runtimes
#./ingredients/dev/git-credential-manager-core.sh #Git Crendential Manager (.NET Core based)
#./ingredients/dev/postman.sh #Postman
#./ingredients/dev/vscode.sh #Visual Studio Code
#./ingredients/dev/vscode-vim.sh #vim extension for Visual Studio Code [Requires /dev/vscode ingredient]
#./ingredients/dev/vscode-wayland.sh #Native Wayland Support for VSCode [Requires /dev/vscode ingredient]

# 3. Web
# --------------------------------------------------------------------------
#./ingredients/web/firefox.sh #Firefox
#./ingredients/web/firefox-wayland.sh #Native Wayland Support for Firefox [Requires /web/firefox ingredient]
#./ingredients/web/google-chrome.sh #Google Chrome
#./ingredients/web/google-chrome-wayland.sh #Native Wayland Support for Google Chrome [Requires /web/google-chrome ingredient]
#./ingredients/web/remmina.sh #Remmina RDP client
#./ingredients/web/slack.sh #Slack

# 4. Productivity
# --------------------------------------------------------------------------
#./ingredients/productivity/flameshot.sh #Flameshot (screenshot application)
#./ingredients/productivity/gromit-mpx.sh #Draw/highlight on your screen (useful for presentations)

# 5. Media
# --------------------------------------------------------------------------
#./ingredients/media/codecs.sh #Codecs for Audio, Images, and Video
#./ingredients/media/gstreamer.sh #Additional GStreamer plugins
#./ingredients/media/pulseeffects.sh #PulseEffects + Perfect EQ
#./ingredients/media/tauon-music-box.sh #Tauon Music Box
#./ingredients/media/vlc.sh #VLC media player

# 6. Gaming
# --------------------------------------------------------------------------
#./ingredients/gaming/steam.sh steam #Steam gaming platform

# 7. Hardware Related
# --------------------------------------------------------------------------
#./ingredients/hardware/cpu-generic_cpupower-gui.sh #GUI utility to set CPU govenor settings
#./ingredients/hardware/cpu-intel_undervolt-support.sh #Utilities neccessary to undervolt Intel CPUs
#./ingredients/hardware/logitec-mouse_solaar.sh #GUI application for managing logitec unifying receivers

# 8. System Monitoring
# --------------------------------------------------------------------------
#./ingredients/system-monitor/btop.sh #btop: a terminal based system monitoring tool (like htop but better)

# 9. VM
# --------------------------------------------------------------------------
#./ingredients/vm/kvm-qemu-guest.sh #KVM/QEMU guest utilities (only install if running as VM)
#./ingredients/vm/kvm-qemu-host.sh #KVM/QEMU host installation and configuration

# 10. Icons
# --------------------------------------------------------------------------
#./ingredients/icons/papirus-icons-folders.sh indigo #Supplmental colored folders for Papirus icon theme [Requires /icons/papirus-icons ingredient]
# Folder colors: black, bluegrey, brown, deeporange, grey, magenta, orange, paleorange, red, violet, yaru, blue, breeze, cyan, green, indigo, nordic, palebrown, pink, teal, white, yellow
#./ingredients/icons/papirus-icons.sh #Papirus icon theme

# 11. Fonts
# --------------------------------------------------------------------------
#./ingredients/fonts/enhanced-fonts.sh #Install and configure fonts: Roboto, FiraCode, JetBrains Mono, Liberation Fonts
#./ingredients/fonts/jetbrains-mono-vscode.sh #JetBrains Mono font for Visual Studio Code [Requires /dev/vscode and /fonts/enhanced-fonts ingredients]

# 12. Themes
# --------------------------------------------------------------------------
#./ingredients/themes/dracula-gedit.sh #Dracula theme for gedit
#./ingredients/themes/dracula-gnome-terminal.sh #Dracula theme for Gnome Terminal
#./ingredients/themes/dracula-gtk.sh #Dracula theme for GTK
#./ingredients/themes/dracula-vscode.sh #Dracula theme for VSCode [Requires /dev/vscode ingredient]

# 13. Gnome Extensions
# --------------------------------------------------------------------------
#./ingredients/gnome-ext/blur-my-shell.sh #Blur My Shell Gnome extension https://github.com/aunetx/blur-my-shell
#./ingredients/gnome-ext/just-perfection.sh #Just Prefection Gnome Extension https://gitlab.com/justperfection.channel/just-perfection-gnome-shell-desktop
#./ingredients/gnome-ext/tray-icons.sh #Tray Icons Reloaded Gnome Extension https://github.com/MartinPL/Tray-Icons-Reloaded

# 14. Additional Packages
# --------------------------------------------------------------------------
# paru -S --noconfirm --needed {package1} {package2} ...

}

main "$@"
