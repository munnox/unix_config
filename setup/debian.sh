#!/bin/bash


# =========================== DOCKER =============================
# Source <https://docs.docker.com/install/linux/docker-ce/ubuntu/>
# Install Docker CE on linux
#
# Covenience script
# curl -fsSL https://get.docker.com -o get-docker.sh

function setup_test_docker() {
    sudo docker run hello-world
}

function setup_remove_docker() {
    sudo apt-get remove docker docker-engine docker.io containerd runc
}

function setup_install_u1804_dockerce() {
    sudo apt-get update
    sudo apt-get install \
        apt-transport-https \
        ca-certificates \
        curl \
        gnupg2 \
        software-properties-common

    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

    sudo apt-key fingerprint 0EBFCD88

    # Should be "9DC8 5822 9FC7 DD38 854A E2D8 8D81 803C 0EBF CD88"
    echo "Should be \"9DC8 5822 9FC7 DD38 854A E2D8 8D81 803C 0EBF CD88\""

    sudo add-apt-repository \
       "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
	$(lsb_release -cs) stable"

    sudo apt-get update

    sudo apt-get install docker-ce docker-ce-cli containerd.io


}

function setup_install_pi_dockerce() {
    sudo apt-get update
    sudo apt-get install \
        apt-transport-https \
        ca-certificates \
        curl \
        gnupg2 \
        software-properties-common

    curl -fsSL https://download.docker.com/linux/raspbian/gpg | sudo apt-key add -

    sudo apt-key fingerprint 0EBFCD88

    # Should be "9DC8 5822 9FC7 DD38 854A E2D8 8D81 803C 0EBF CD88"
    echo "Should be \"9DC8 5822 9FC7 DD38 854A E2D8 8D81 803C 0EBF CD88\""

    # or armhf , stretch
    sudo add-apt-repository \
       "deb [arch=arm64] https://download.docker.com/linux/raspbian \
	$(lsb_release -cs) stable"

    sudo apt-get update

    sudo apt-get install docker-ce docker-ce-cli containerd.io


}


# =================== Ansible =======================================
# Source <https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html?extIdCarryOver=true&sc_cid=701f2000001OH7YAAW#latest-releases-via-apt-ubuntu>
# Install Ansible on ubuntu 18.04

function setup_install_ansible() {
    sudo apt update
    sudo apt install software-properties-common
    sudo apt-add-repository --yes --update ppa:ansible/ansible
    sudo apt install ansible
}

function setup_install_python_ansible() {
   sudo apt install python3 python-venv python3-pip
   sudo pip3 install ansible
}

# ======================== KVM =========================
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

