#!/bin/sh
# VM - KVM/Qemu Host

# Installs all the neccessary packages to support running / managing KVM virtual machines
# Note edk2-ovmf supports VMs with UEFI instead of traditional BIOS
pacman -Syu --noconfirm --needed qemu virt-manager virt-viewer dnsmasq vde2 bridge-utils openbsd-netcat ebtables edk2-ovmf

sudo systemctl enable libvirtd.service
sudo systemctl start libvirtd.service

# Tweak some permissions for libvirtd to allow non-root users to interact with KVM virtual machines
sudo sed --in-place "s/#unix_sock_group/unix_sock_group/" "/etc/libvirt/libvirtd.conf"
sudo sed --in-place "s/#unix_sock_ro_perms/unix_sock_ro_perms/" "/etc/libvirt/libvirtd.conf"

# Add user to the correct groups
sudo usermod -a -G libvirt $USER
sudo usermod -a -G libvirt-qemu $USER

sudo systemctl restart libvirtd.service

# Write default network configuration to XML file
    cat <<EOT > "default.xml"
<network>
  <name>default</name>
  <uuid>b0f515a0-3e6c-44a7-833b-0e6ca1c7c103</uuid>
  <forward mode='nat'/>
  <bridge name='virbr0' stp='on' delay='0'/>
  <mac address='52:54:00:70:18:6c'/>
  <ip address='192.168.122.1' netmask='255.255.255.0'>
    <dhcp>
      <range start='192.168.122.2' end='192.168.122.254'/>
    </dhcp>
  </ip>
</network>
EOT

# Set up a default network, and set it to autostart
sudo virsh net-define --file ./default.xml
sudo virsh net-start default
sudo virsh net-autostart --network default

rm default.xml
