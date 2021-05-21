#!/bin/bash
# recipe.sh : 2021-05-20-19:51:02
# NOTE: Please uncomment the ingredients you wish to install before running!
# --------------------------------------------------------------------------

function main() {

# 1. Core
# --------------------------------------------------------------------------
./ingredients/core/0_mandatory.sh #Mandatory programs & utilities
#./ingredients/core/fish.sh #Fish shell
#./ingredients/core/neovim.sh #Neovim (replaces vim)
#./ingredients/core/pipewire.sh #Pipewire (replaces Pulseaudio)

# 2. Development
# --------------------------------------------------------------------------
#./ingredients/dev/git.sh "Firstname Lastname" "myname@mydomain.com" #Git installation and configuration
#./ingredients/dev/ms-dotnet.sh #.NET Core SDK and Runtimes
#./ingredients/dev/vscode.sh #Visual Studio Code
#./ingredients/dev/vscode-vim.sh #vim extension for Visual Studio Code [Requires /dev/vscode ingredient]

# 3. Web
# --------------------------------------------------------------------------
#./ingredients/web/edge.sh #Microsoft Edge (currently in beta)
#./ingredients/web/firefox.sh #Firefox
#./ingredients/web/google-chrome.sh #Google Chrome
#./ingredients/web/slack.sh #Slack

# 4. Productivity
# --------------------------------------------------------------------------
#./ingredients/productivity/flameshot.sh #Flameshot (screenshot application)

# 5. Media
# --------------------------------------------------------------------------
#./ingredients/media/pulseeffects.sh #PulseEffects + Perfect EQ
#./ingredients/media/tauon-music-box.sh #Tauon Music Box
#./ingredients/media/vlc-codecs.sh #VLC media player and codecs

# 6. Gaming
# --------------------------------------------------------------------------
#./ingredients/gaming/steam.sh steam #Steam gaming platform

# 7. CPU Utilities
# --------------------------------------------------------------------------
#./ingredients/cpu/cpupower-gui.sh #GUI utility to set CPU govenor settings
#./ingredients/cpu/intel-undervolt-support.sh bc #Utilities neccessary to undervolt Intel CPUs

# 8. System Monitoring
# --------------------------------------------------------------------------
#./ingredients/system-monitor/bpytop.sh #bpytop: a terminal based system monitoring tool (like htop but better)

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
#./ingredients/fonts/enhanced-fonts.sh #Install and configure fonts: FiraCode, Roboto, JetBrains Mono
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

# 14. Additional Packages
# --------------------------------------------------------------------------
# paru -S --noconfirm --needed {package1} {package2} ...

}

main "$@"
