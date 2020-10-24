#!/bin/bash
# Backup - btrbk

#|# Btrbk: Command line btrfs backup utility
#|# Usage: brtbk.sh {/path/to/src_btr_root_vol} {snapshot-subvolume-name} {/path/to/backup_btr_root_vol} {backup_label}
#|# Example: btrbk.sh /mnt/btr_root_vol btr_snapshots /run/media/robert/MyBackupHD MyLaptop
#|#./ingredients/backup/brtbk.sh {/path/to/src_btr_root_vol} {snapshot-subvolume-name} {/path/to/backup_btr_root_vol} {backup_label}
#|# ------------------------

DIR=$(dirname "$0")
source $DIR/../_helper/_common-functions.sh

# Create a btrbk.conf for backups to an external HD?
BTRBK_CREATE_EXT_HD_CONFIG="false"

# If you selected true above, define some details for the btrbk.conf file
# Path to the source btrfs root volume
BTRBK_SRC_ROOT_VOL_PATH="" # /mnt/btr_root_vol

# Name of the btrfs subvolume where local snapshots will be created
BTRBK_SNAPSHOT_SUBVOL_NAME="" # btr_snapshots

# Target btrfs root volume (which will contain backups from source)
# This is normally the path to the external HD e.g. /run/media/${USER}/xxx
# IMPORTANT: filesystem of external HD *must* also be btrfs
BTRBK_TARGET_ROOT_VOL_PATH="" 

# All snapshots are prefixed with this so they can be more easily identified (often times the hostname)
BTRBK_BACKUP_LABEL="" # soagi

function main() {
    
    check_args "$@"

    if [[ "$#" -eq 4 ]]; then
        BTRBK_CREATE_EXT_HD_CONFIG="true"
        BTRBK_SRC_ROOT_VOL_PATH="$1"
        BTRBK_SNAPSHOT_SUBVOL_NAME="$2"
        BTRBK_TARGET_ROOT_VOL_PATH="$3"
        BTRBK_BACKUP_LABEL="$4"
    fi

    check_variables
    check_critical_prereqs
    install
}

function install() {

    yay -Syu --noconfirm --needed btrbk

    if [[ "$BTRBK_CREATE_EXT_HD_CONFIG" != "true" ]]; then
        echo "Skipping the creation of a btrbk.conf file..."

        if [[ -e /etc/btrbk/btrbk.conf ]]; then
            echo -e "${YELLOW}Warning: there is an existing /etc/btrbk/btrbk.conf file.${NC}"
        fi

        exit
    fi

    # Generate btrbk.conf
    echo "Generating /etc/btrbk/btrbk.conf file..."

    cat <<EOT > "btrbk.conf"
snapshot_preserve_min   2d
snapshot_preserve      14d

target_preserve_min     2d
target_preserve        20d 10w *m

snapshot_create        ondemand
snapshot_dir           BTRBK_SNAPSHOT_SUBVOL_NAME

volume BTRBK_SRC_ROOT_VOL_PATH
  target BTRBK_TARGET_ROOT_VOL_PATH/BTRBK_BACKUP_LABEL
  subvolume rootfs
  subvolume home
EOT

    sed -i 's/BTRBK_SRC_ROOT_VOL_PATH/'"${BTRBK_SRC_ROOT_VOL_PATH//\//\\/}"'/' btrbk.conf
    sed -i 's/BTRBK_SNAPSHOT_SUBVOL_NAME/'"${BTRBK_SNAPSHOT_SUBVOL_NAME}"'/' btrbk.conf
    sed -i 's/BTRBK_TARGET_ROOT_VOL_PATH/'"${BTRBK_TARGET_ROOT_VOL_PATH//\//\\/}"'/' btrbk.conf
    sed -i 's/BTRBK_BACKUP_LABEL/'"${BTRBK_BACKUP_LABEL}"'/' btrbk.conf

    sudo mv btrbk.conf /etc/btrbk/.

    echo "===/etc/btrbk/btrbk.conf==="
    cat /etc/btrbk/btrbk.conf
    echo "==========================="
    
    echo "You can run 'sudo btrbk dryrun' to test out the generated config."
    echo "You can run 'sudo btrbk run' to create a local snapshot and back it up to the target location."
}

function check_args() {
    
    print_help_if_neccessary "$@"
    
    if [[ "$#" -ne 0 && "$#" -ne 4 ]]; then
        echo -e "${RED}Error: this script must be run with either 0 arguments (install btrbk only), or with 4 arguments (install btrbk and create btrbk.conf file).${NC}"
        echo ""
        print_help
        exit 1
    fi
}

function print_help() {

    echo -e "${LIGHT_BLUE}  Usage: "$0" {/path/to/src_btr_root_vol} {snapshot-subvolume-name} {/path/to/backup_btr_root_vol} {backup_label}${NC}"
    echo -e "${BLUE}Example: "$0"${NC} : installs btrbk without generating a btrbk.conf file."
    echo -e "${BLUE}Example: "$0" /mnt/btr_root_vol btr_snapshots /run/media/robert/MyBackupHD myLaptop${NC} : installs btrbk and generates a btrbk.conf file to support backps to an external HD."
}

function check_variables() {

    check_variables_boolean "BTRBK_CREATE_EXT_HD_CONFIG" "$BTRBK_CREATE_EXT_HD_CONFIG"

    if [[ "$BTRBK_CREATE_EXT_HD_CONFIG" == "true" ]]; then
        check_variables_value "BTRBK_SRC_ROOT_VOL_PATH" "$BTRBK_SRC_ROOT_VOL_PATH"
        check_variables_value "BTRBK_SNAPSHOT_SUBVOL_NAME" "$BTRBK_SNAPSHOT_SUBVOL_NAME"
        check_variables_value "BTRBK_TARGET_ROOT_VOL_PATH" "$BTRBK_TARGET_ROOT_VOL_PATH"
        check_variables_value "BTRBK_BACKUP_LABEL" "$BTRBK_BACKUP_LABEL"
    fi
}

function check_critical_prereqs() {
    check_yay_prereq
}

main "$@"