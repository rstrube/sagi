#!/bin/bash

#|# KVM/Quem guest utilities (only install if running as VM)
#|#./ingredients/vm/kvm-qemu-guest.sh

DIR=$(dirname "$0")
source $DIR/../_helper/_common-functions.sh

# Install Qemu guest agent and Spice tools
sudo pacman -Syu --noconfirm --needed qemu-guest-agent spice-vdagent

# Enable the Qemu guest agent service
sudo systemctl enable qemu-ga.service
sudo systemctl start qemu-ga.service
