#!/bin/bash

#sudo apt update && sudo apt upgrade -y
#sudo apt install -y python3.9 python3-pip
#sudo python3.9 -m pip install poetry
python3 -m pip install --update --user pip poetry
poetry install
poetry run ansible-playbook deploy.yml -K

# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"