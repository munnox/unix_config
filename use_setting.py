#!/usr/bin/env python3
# The Above allow this script to be run on the bash line with
# ./use_setting.py
# requires `chmod +x foo` to enable execute

# Use config setting python

import sys
import os
import shutil

HOME = os.getenv("HOME", None)
LOCAL_REPO="DIR"
print(LOCAL_REPO)
CONFIG_PATH=os.path.join(LOCAL_REPO, "configs")
BASH_PATTERN="source {LOCAL_REPO}//bash//bashrc".format(LOCAL_REPO=LOCAL_REPO)
VIM_PATTERN="source {LOCAL_REPO}/configs/vim/vimrc".format(LOCAL_REPO=LOCAL_REPO)
PATH_GIT="{LOCAL_REPO}/configs/git/gitconfig".format(LOCAL_REPO=LOCAL_REPO)
PATH_TMUX="{LOCAL_REPO}/configs/tmux/tmux.conf".format(LOCAL_REPO=LOCAL_REPO)
PATH_I3="{LOCAL_REPO}/configs/i3/config".format(LOCAL_REPO=LOCAL_REPO)

CONFIG_PATH_BASH=f"{HOME}/.bashrc"
CONFIG_PATH_VIM=f"{HOME}/.vimrc"
CONFIG_PATH_NEOVIM=f"{HOME}/.config/nvim/"
CONFIG_FILE_NEOVIM=f"{HOME}/.config/nvim/vimrc"

print(BASH_PATTERN)
print(VIM_PATTERN)
print(PATH_GIT)
print(PATH_TMUX)

def find_in_file(filename, pattern):
    with open(filename, "r") as f:
        if f.read().find(pattern):
            return True
    return False
# TODO Test and copy BASH config

if os.path.exists(CONFIG_PATH_BASH):
    print("bashrc exists")
    if find_in_file(CONFIG_PATH_BASH, BASH_PATTERN):
        print("Bash redirect exists")


# TODO Test and copy neovim

# TODO Test and cope vimrc

# TODO Test and copy Tmux config

# TODO Test and copy i3 config



