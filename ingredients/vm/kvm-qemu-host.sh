#!/bin/bash

#|# KVM/Quemu host installation and configuration
#|#./ingredients/vm/kvm-qemu-host.sh

DIR=$(dirname "$0")
source $DIR/../_helper/_common-functions.sh

# Installs all the neccessary packages to support running / managing KVM virtual machines
# Note edk2-ovmf supports VMs with UEFI instead of traditional BIOS
sudo pacman -Syu --noconfirm --needed qemu virt-manager virt-viewer dnsmasq vde2 bridge-utils openbsd-netcat ebtables edk2-ovmf dmidecode

# Tweak some permissions for libvirtd to allow non-root users to interact with KVM virtual machines
sudo sed -i "s/#unix_sock_group/unix_sock_group/" "/etc/libvirt/libvirtd.conf"
sudo sed -i "s/#unix_sock_ro_perms/unix_sock_ro_perms/" "/etc/libvirt/libvirtd.conf"

# Add user to the correct groups
sudo usermod -a -G libvirt $USER

sudo systemctl enable libvirtd.service

sudo virsh net-start default
sudo virsh net-autostart --network default

echo "===/etc/libvirt/qemu/networks/default.xml==="
sudo cat /etc/libvirt/qemu/networks/default.xml
echo "============================================"

echo -e "${YELLOW}Warning: you will need to reboot in order for the configuration changes to take affect.${NC}"
