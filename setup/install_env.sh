#!/bin/bash
# source https://help.ubuntu.com/community/KVM/Installation

function install_neovim() {
    curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
    chmod u+x nvim.appimage
    # ./nvim.appimage
}

function install_python() {
    sudo apt update
    sudo apt upgrade
    sudo apt install python3-dev python3-venv libffi-dev gcc libssl-dev git

}

function install_podman() {
    # Source https://podman.io/getting-started/installation
    . /etc/os-release
echo "deb https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/xUbuntu_${VERSION_ID}/ /" | sudo tee /etc/apt/sources.list.d/devel:kubic:libcontainers:stable.list
curl -L https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/xUbuntu_${VERSION_ID}/Release.key | sudo apt-key add -
sudo apt-get update
sudo apt-get -y upgrade 
sudo apt-get -y install podman
}


