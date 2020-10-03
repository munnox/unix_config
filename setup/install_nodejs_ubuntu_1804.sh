#!/bin/bash
# Source <https://www.rust-lang.org/tools/install>
# Install Docker CE on linux

function install_nodejs() {
    # useful programs
    # sudo apt install git tmux neovim gcc
    # Required program
    sudo apt install curl
    # Sourced from https://ostechnix.com/install-node-js-linux/
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh > nvm_install.sh
    NVM_DIR="${HOME}/.ramnvm"
    mkdir -p ${NVM_DIR}
    bash nvm_install.sh
    source ~/.bashrc
    # nvm ls-remote
    # nvm list
    nvm install v14.13.0
    # curl https://nodejs.org/dist/v12.18.4/node-v12.18.4-linux-x64.tar.xz > nodejs.tar.xz
    
    
}

