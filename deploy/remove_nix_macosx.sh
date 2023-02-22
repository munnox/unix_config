#!/bin/bash
# VERY opinionated removal script and config setup for NIX
# since Macosx keep breaking the install
# run with all due care
# Author Robert Munnoch


if ! [[ -f /etc/bashrc.backup-before-nix ]]; then
    echo "No bash Backup found"
else
    echo "BASH Backup found restoring that"
    sudo rm /etc/bashrc
    sudo mv /etc/bashrc.backup-before-nix /etc/bashrc
fi
if ! [[ -f /etc/zshrc.backup-before-nix ]]; then
    echo "No zsh Backup found"
else
    echo "ZSH Backup found restoring that"
    sudo rm /etc/zshrc
    sudo mv /etc/zshrc.backup-before-nix /etc/zshrc
fi
