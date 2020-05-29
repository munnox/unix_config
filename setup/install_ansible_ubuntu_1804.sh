#!/bin/bash
# Source <https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html?extIdCarryOver=true&sc_cid=701f2000001OH7YAAW#latest-releases-via-apt-ubuntu>
# Install Ansible on ubuntu 18.04

function install_ansible() {
    sudo apt update
    sudo apt install software-properties-common
    sudo apt-add-repository --yes --update ppa:ansible/ansible
    sudo apt install ansible
}

function install_python_ansible() {
   sudo apt install python3 python-venv python3-pip
   sudo pip3 install ansible
}
