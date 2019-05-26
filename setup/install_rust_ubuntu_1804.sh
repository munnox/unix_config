#!/bin/bash
# Source <https://www.rust-lang.org/tools/install>
# Install Docker CE on linux

function install_rust() {
    # useful programs
    # sudo apt install git tmux neovim gcc
    # Required program
    sudo apt install curl
    curl https://sh.rustup.rs -sSf | sh
}

