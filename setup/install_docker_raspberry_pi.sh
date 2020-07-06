#!/bin/bash
# Source <https://docs.docker.com/install/linux/docker-ce/ubuntu/>
# Install Docker CE on linux
#
# Covenience script
# curl -fsSL https://get.docker.com -o get-docker.sh

function remove_docker() {
    sudo apt-get remove docker docker-engine docker.io containerd runc
}

function install_dockerce() {
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

function test_docker() {
    sudo docker run hello-world
}
