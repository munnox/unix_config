#!/bin/bash
# VERY opinionated removal script and config setup for NIX
# since Macosx keep breaking the install
# run with all due care
# Author Robert Munnoch
ls /etc/bash*
grep nix /etc/bashrc
grep nix /etc/bash.bashrc
ls /etc/zsh*
grep nix /etc/zshrc

if ! [[ -f /etc/bashrc.backup-before-nix ]]; then
    echo "No bash Backup found"
else
    echo "BASH Backup found restoring that"
    sudo rm /etc/bashrc
    sudo mv /etc/bashrc.backup-before-nix /etc/bashrc
    sudo mv /etc/bash.bashrc.backup-before-nix /etc/bash.bashrc
fi
if ! [[ -f /etc/bash.bashrc.backup-before-nix ]]; then
    echo "No bash.bashrc Backup found"
else
    echo "BASH.bashrc Backup found restoring that"
    sudo rm /etc/bash.bashrc
    sudo mv /etc/bash.bashrc.backup-before-nix /etc/bash.bashrc
fi
if ! [[ -f /etc/zshrc.backup-before-nix ]]; then
    echo "No zsh Backup found"
else
    echo "ZSH Backup found restoring that"
    sudo rm /etc/zshrc
    sudo mv /etc/zshrc.backup-before-nix /etc/zshrc
fi
