#!/bin/bash
# source https://help.ubuntu.com/community/KVM/Installation

function install_neovim() {
    curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
    chmod u+x nvim.appimage
    # ./nvim.appimage
}


