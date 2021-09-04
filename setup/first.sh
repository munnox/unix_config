#!/bin/sh

sudo apt install curl git tmux python3.8 python3-pip
python3.8 -m pip install pipenv

# Neovim
sudo curl -o /usr/local/bin/nvim -LO https://github.com/neovim/neovim/releases/download/stable/nvim.appimage
sudo chmod ugo+x /usr/local/bin/nvim
sudo ln -s /usr/local/bin/nvim /usr/local/bin/vim
