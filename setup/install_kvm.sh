#!/bin/bash
# source https://help.ubuntu.com/community/KVM/Installation

function install_kvm() {
    sudo apt-get install qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils
    # libvirt-bin provides libvirtd which you need to administer qemu and kvm instances using libvirt

    # qemu-kvm (kvm in Karmic and earlier) is the backend

    # ubuntu-vm-builder powerful command line tool for building virtual machines

    # bridge-utils provides a bridge from your network to the virtual machines
        
    sudo adduser `id -un` libvirt
    sudo adduser `id -un` kvm

    virsh list --all

    sudo apt-get install virt-manager

    # lsmod | grep 8021q

    # enable nested vm's
    sudo touch /etc/modprobe.d/kvm.conf
    echo "options kvm_intel nested=1" | sudo tee -a /etc/modprobe.d/kvm.conf

}


