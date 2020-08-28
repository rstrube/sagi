#!/bin/bash
# Core - btrbk

# Do you want the installation to create a btrbk.conf for backups to an external HD?
CREATE_BACKUP_TO_EXT_HD_BTRBK_CONFIG="false"

# If you selected true above, define some details for the configuration file
# This is the path to the source btrfs root volume
BTR_SRC_ROOT_VOL_PATH="/mnt/btr_root_vol"

# This is the name of the btrfs subvolume where local snapshots will be created
BTR_SNAPSHOT_SUBVOL_NAME="btr_snapshots"

# This is the path to the target btrfs root volume (which will contain backups from source)
# This is normally the path to the external HD e.g. /run/media/${USER}/xxx
# IMPORTANT: filesystem of external HD *must* also be btrfs
BTR_TARGET_ROOT_VOL_PATH="" 

# This is used to name the snapshots so they can be more easily identified
HOSTNAME="soagi"

source _common-sh-functions.sh

function main() {
    
    check_variables
    check_critical_prereqs
    install
}

function install() {

    if [[ ! -e /usr/bin/btrbk ]]; then
        yay -S --noconfirm btrbk
    fi

    if [ "$CREATE_BACKUP_TO_EXT_HD_BTRBK_CONFIG" != "true" ]; then
        echo "Skipping the creation of a btrbk.conf file..."
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
snapshot_dir           BTR_SNAPSHOT_SUBVOL_NAME

volume BTR_SRC_ROOT_VOL_PATH
  target BTR_TARGET_ROOT_VOL_PATH/HOSTNAME
  subvolume rootfs
  subvolume home
EOT

    sed -i 's/BTR_SRC_ROOT_VOL_PATH/'"${BTR_SRC_ROOT_VOL_PATH//\//\\/}"'/' btrbk.conf
    sed -i 's/BTR_SNAPSHOT_SUBVOL_NAME/'"${BTR_SNAPSHOT_SUBVOL_NAME}"'/' btrbk.conf
    sed -i 's/BTR_TARGET_ROOT_VOL_PATH/'"${BTR_TARGET_ROOT_VOL_PATH//\//\\/}"'/' btrbk.conf
    sed -i 's/HOSTNAME/'"${HOSTNAME}"'/' btrbk.conf

    sudo mv btrbk.conf /etc/btrbk/.

    echo "Finished generating /etc/btrbk/btrbk.conf..."
    echo "===CONFIG==="
    cat /etc/btrbk/btrbk.conf
    echo "====END===="
    echo "You can run 'sudo btrbk dryrun' to test out the generated config."
    echo "You can run 'sudo btrbk run' to create a local snapshot and back it up to the target location."
}

function check_variables() {

    check_variables_boolean "CREATE_BACKUP_TO_EXT_HD_BTRBK_CONFIG" "$CREATE_BACKUP_TO_EXT_HD_BTRBK_CONFIG"

    if [ "$CREATE_BACKUP_TO_EXT_HD_BTRBK_CONFIG" == "true" ]; then
        check_variables_value "BTR_SRC_ROOT_VOL_PATH" "$BTR_SRC_ROOT_VOL_PATH"
        check_variables_value "BTR_SNAPSHOT_SUBVOL_NAME" "$BTR_SNAPSHOT_SUBVOL_NAME"
        check_variables_value "BTR_TARGET_ROOT_VOL_PATH" "$BTR_TARGET_ROOT_VOL_PATH"
        check_variables_value "HOSTNAME" "$HOSTNAME"
    fi
}

function check_critical_prereqs() {
    check_yay_prereq
}

main $@