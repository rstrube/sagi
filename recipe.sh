#!/bin/bash
# recipe.sh : 2021-01-08-10:57:08
# NOTE: Please uncomment the ingredients you wish to install before running!
# --------------------------------------------------------------------------

function main() {

# 1. Core
# --------------------------------------------------------------------------
./ingredients/core/utils.sh #Mandatory programs & utilities
#./ingredients/core/zsh.sh #Zsh + Oh-my-Zsh

# 2. Gnome
# --------------------------------------------------------------------------
#./ingredients/gnome/fonts.sh #Gnome fonts
#./ingredients/gnome/icons.sh #Gnome icons
#./ingredients/gnome/theme-dracula-1.sh #Gnome Dracula theme
#./ingredients/gnome/theme-dracula-2-icons.sh #Gnome Dracula theme icons (requires Gnome icons ingredient)
#./ingredients/gnome/theme-dracula-3-flatpak.sh #Gnome Dracula theme Flatpak support

# 3. Development
# --------------------------------------------------------------------------
#install-pkg git #Git installation and configuration
#git config --global user.name "First Last"
#git config --global user.email "myname@mydomain.com"
#install-pkg git-credential-manager-bin #Git Credential Manager (for Git on Azure DevOps)
#install-pkg dotnet-runtime dotnet-sdk aspnet-targeting-pack aspnet-runtime #.NET Core runitem and SDK
#install-pkg visual-studio-code-bin #VSCode
#./ingredients/dev/vscode-2-fonts.sh #VSCode font configuration (requires Gnome fonts ingredient)
#./ingredients/dev/vscode-3-dracula-theme.sh #VSCode Dracula theme

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

# 8. Backup
# --------------------------------------------------------------------------
#Btrbk: Command line btrfs backup utility
#Usage: brtbk.sh {/path/to/src_btr_root_vol} {snapshot-subvolume-name} {/path/to/backup_btr_root_vol} {backup_label}
#Example: btrbk.sh /mnt/btr_root_vol btr_snapshots /run/media/robert/MyBackupHD MyLaptop
#./ingredients/backup/brtbk.sh {/path/to/src_btr_root_vol} {snapshot-subvolume-name} {/path/to/backup_btr_root_vol} {backup_label}

# 9. CPU Utilities
# --------------------------------------------------------------------------
#install-pkg cpupower-gui #GUI utility to set CPU govenor settings
#install-pkg msr-tools bc #Utilities neccessary to undervolt Intel CPUs

# 10. VM
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

    yay -Syu --noconfirm --needed "$@"
}


function install-fp() {

    flatpak install -y flathub "$@"
}

main "$@"
