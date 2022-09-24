#!/bin/bash

function rocky() {
  # set -x
  echo "bootstraping python and ansible for rocky linux"
  # sudo dnf install python38-devel python38-pip libffi-dev gcc libssl-dev git curl tmux
  sudo dnf install -y git curl tmux
      # python38-devel python38-pip

  # install_pipx
  # install_pipx_envs
  install_pip_envs
}

function ubuntu() {
  echo "bootstraping python and ansible for ubuntu linux"
  sudo apt install -y git curl tmux
      # \
      # python3.8-dev python3.8-venv \
      # python3-pip python3-venv libffi-dev \
      # gcc libssl-dev

  # install_pipx
  # install_pipx_envs
  install_pip_envs
}

function mac() {
  echo "bootstraping python and ansible for mac"
  # Setup a basic python 3.8 environment
  install_pip_envs
}

function install_pipx {
  # Setup a basic python 3.8 environment
  python3 -m pip install --user pipx
  # Add ~/.local/bin to the the PATH
  python3 -m pipx ensurepath
  # Following needs to be added to .bashrc"
  echo "eval $(register-python-argcomplete pipx)" >> ~/.bashrc

  source ~/.bashrc
}

function install_pipx_envs {
  # pipx install pipenv
  # pipenv install --three

  pipx install poetry
}

function install_pip_envs {
  # python3 get-pip.py
  python3 -m pip install --user --upgrade pip
  python3 -m pip install --user --upgrade poetry
}

case $1 in
  rocky)
    echo "run rocky"
    rocky
    ;;
  ubuntu)
    echo "run ubuntu"
    ubuntu
    ;;
  mac)
    echo "run mac"
    mac
    ;;
  *)
    echo "Select either 'ubuntu' or 'rocky'"
    ;;
esac;
