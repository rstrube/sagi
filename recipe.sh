#!/bin/bash
# recipe.sh : 2021-03-07-09:27:40
# NOTE: Please uncomment the ingredients you wish to install before running!
# --------------------------------------------------------------------------

function main() {

# 1. Core
# --------------------------------------------------------------------------
./ingredients/core/0_mandatory.sh #Mandatory programs & utilities
#./ingredients/core/fish.sh #Fish shell
#./ingredients/core/neovim.sh #Neovim (replaces vim)
#./ingredients/core/pipewire.sh #Pipewire (replaces Pulseaudio)

# 2. Gnome
# --------------------------------------------------------------------------
#./ingredients/gnome/fonts.sh #Gnome fonts
#./ingredients/gnome/icons.sh #Gnome icons
#./ingredients/gnome/theme-dracula.sh #Gnome Dracula theme
#./ingredients/gnome/theme-flatpak-dracula.sh #Gnome Dracula theme Flatpak support

# 3. Development
# --------------------------------------------------------------------------
#./ingredients/dev/git-1.sh "Firstname Lastname" "myname@mydomain.com" #Git installation and configuration
#install-pkg git-credential-manager-bin #Git Credential Manager (for Git on Azure DevOps)
#install-pkg dotnet-host-bin dotnet-runtime-bin dotnet-sdk-bin dotnet-targeting-pack-bin aspnet-runtime-bin aspnet-targeting-pack-bin #.NET Core runitem and SDK
#install-pkg visual-studio-code-bin #VSCode
#./ingredients/dev/vscode-2-fonts.sh #VSCode font configuration (requires Gnome fonts ingredient)
#./ingredients/dev/vscode-3-vim.sh #VSCode vim extension
#./ingredients/dev/vscode-4-theme-dracula.sh #VSCode Dracula theme extension

# 4. Web
# --------------------------------------------------------------------------
#install-pkg chromium #Chromium
#./ingredients/web/chromium-2-enable-vaapi.sh #Chromium enable VAAPI support (requires Chromium ingredient)
#install-pkg firefox #Firefox
#install-pkg slack-desktop #Slack
#install-pkg teams #Microsoft Teams

# 5. Productivity
# --------------------------------------------------------------------------
#install-pkg flameshot #Flameshot (screenshot application)
#install-pkg gtg #Getting this Gnome (TTD application)

# 6. Media
# --------------------------------------------------------------------------
#./ingredients/media/pulseeffects.sh #PulseEffects + Perfect EQ
#install-pkg tauon-music-box #Tauon Music Box
#install-pkg a52dec aribb24 faac faad2 flac jasper lame libdca libdv libdvbpsi libmad libmatroska libmpeg2 libtheora libvorbis libxv opus wavpack x264 xvidcore libdvdcss vlc #VLC media player and codecs

# 7. Gaming
# --------------------------------------------------------------------------
#install-pkg steam #Steam gaming platform

# 8. CPU Utilities
# --------------------------------------------------------------------------
#install-pkg cpupower-gui #GUI utility to set CPU govenor settings
#install-pkg msr-tools bc #Utilities neccessary to undervolt Intel CPUs

# 9. VM
# --------------------------------------------------------------------------
#./ingredients/vm/kvm-qemu-guest.sh #KVM/Quem guest utilities (only install if running as VM)
#./ingredients/vm/kvm-qemu-host.sh #KVM/Quemu host installation and configuration

# 11. Additional Packages
# --------------------------------------------------------------------------
#install-pkg add-pkg1 add-pkg2 ...

# 12. Additional Flatpaks
# --------------------------------------------------------------------------
#install-fp add-fp1 add-fp2 ...

}

function install-pkg() {

    paru -Syu --noconfirm --needed "$@"
}


function install-fp() {

    flatpak install -y flathub "$@"
}

main "$@"
