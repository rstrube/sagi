#!/bin/bash
# Soagi Post-Install Recipe (Kitchen Sink)

BTRBK_SRC_ROOT_VOL_PATH="/mnt/btr_root_vol" 
BTRBK_SNAPSHOT_SUBVOL_NAME="btr_snapshots"
BTRBK_TARGET_ROOT_VOL_PATH="/run/media/robert/MyBackupHD" 
BTRBK_BACKUP_LABEL="myLaptop"

# Core applications / utilities
./core_yay.sh
./core_utils.sh
./core_zsh.sh
./core_btrbk.sh $BTRBK_SRC_ROOT_VOL_PATH $BTRBK_SNAPSHOT_SUBVOL_NAME $BTRBK_TARGET_ROOT_VOL_PATH $BTRBK_BACKUP_LABEL

# Web applications / utilities
./web_chromium.sh --enable-vaapi
./web_slack.sh
./web_teams.sh

GIT_USERNAME="Robert Strube"
GIT_EMAIL="robert@mydomain.com"

# Development applications / utilities
./dev_git.sh $GIT_USERNAME $GIT_EMAIL --install-git-credential-manager
./dev_vscode.sh

# Media
./media_codecs-player.sh

# Icons / Fonts / Themes
./gnome_icons.sh
./gnome_fonts.sh --configure-vscode-fonts
./gnome_theme-dracula.sh --configure-vscode-theme --configure-flatpak-theme
