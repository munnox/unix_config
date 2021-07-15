#!/bin/sh

function rocky() {
  sudo yum install python38-devel python38-pip libffi-dev gcc libssl-dev git curl tmux
  
  # Setup a basic python 3.8 environment
  python3 -m pip install --user pipx
  # Add ~/.local/bin to the the PATH
  python3 -m pipx ensurepath
  # Following needs to be added to .bashrc"
  echo "eval $(register-python-argcomplete pipx)" >> ~/.bashrc
  
  source ~/.bashrc
  
  pip install pipenv
  
  pipenv install --three
}

function ubuntu() {
  sudo apt install python3.8-dev python3.8-dev python3.8-venv python3-pip python3-venv libffi-dev gcc libssl-dev git curl tmux
  
  # Setup a basic python 3.8 environment
  python3 -m pip install --user pipx
  # Add ~/.local/bin to the the PATH
  python3 -m pipx ensurepath
  # Following needs to be added to .bashrc"
  echo "eval $(register-python-argcomplete pipx)" >> ~/.bashrc
  
  source ~/.bashrc
  
  pipx install pipenv
  
  pipenv install --three
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
esac;
