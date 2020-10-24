#!/bin/bash
# VM - KVM/Qemu Guest

#|#./ingredients/vm/kvm-qemu-guest.sh # KVM/Qemu tools for guest VMs (only install if this system is a guest VM!)

DIR=$(dirname "$0")
source $DIR/../_helper/_common-functions.sh

# Install Qemu guest agent and Spice tools
sudo pacman -Syu --noconfirm --needed qemu-guest-agent spice-vdagent

# Enable the Qemu guest agent service
sudo systemctl enable qemu-ga.service
sudo systemctl start qemu-ga.service
