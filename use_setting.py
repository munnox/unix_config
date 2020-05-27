#!/usr/bin/env python3
# The Above allow this script to be run on the bash line with
# ./use_setting.py
# requires `chmod +x foo` to enable execute

# Use config setting python

import sys
import os
import shutil
import subprocess

HOME = os.getenv("HOME", None)
PWD = os.path.abspath(".")
LOCAL_REPO=f"{PWD}"
print(LOCAL_REPO)
CONFIG_PATH=os.path.join(LOCAL_REPO, "configs")

def find_in_file(filename, pattern):
    """Look for a pattern in a given file and report"""
    with open(filename, "r") as f:
        if f.read().find(pattern) >= 0:
            return True
    return False

def run_process(*args):
    """Simple wrapper for running a process
    Untested
    """
    sp = subprocess.Popen(args)
    sp.communicate()

def fix_bash():
    # Test and copy BASH config
    print("========== BASH Config ==========")
    BASH_PATTERN=f"source {LOCAL_REPO}/bash/bashrc"
    CONFIG_PATH_BASH=f"{HOME}/.bashrc"

    if os.path.exists(CONFIG_PATH_BASH):
        print(f"'{CONFIG_PATH_BASH}' exists looking to append")
        if find_in_file(CONFIG_PATH_BASH, BASH_PATTERN):
            print(f"'{CONFIG_PATH_BASH}' redirect exists continuing")
        else:
            with open(CONFIG_PATH_BASH, "a") as fa:
                fa.write("\n{0}".format(BASH_PATTERN))
            print(f"'{CONFIG_PATH_BASH}' redirect added")
        
def fix_neovim():
    # Test and copy NEOVIM
    print("========== NEOVIM Config ==========")
    VIM_PATTERN=f"source {LOCAL_REPO}/configs/vim/vimrc"
    CONFIG_FILE_VIM=f"{HOME}/.vimrc"
    CONFIG_PATH_NEOVIM=f"{HOME}/.config/nvim/"
    CONFIG_FILE_NEOVIM=f"{HOME}/.config/nvim/vimrc"

    if os.path.exists(CONFIG_PATH_NEOVIM):
        print(f"'{CONFIG_PATH_NEOVIM}' folder exists")
    else:
        os.mkdir(CONFIG_PATH_NEOVIM)

    # Redirect neovim to the home directory vim config
    with open(CONFIG_FILE_NEOVIM, "w") as f:
        f.write("source ~/.vimrc")

    # Test and copy vimrc
    print("========== VIM Config ==========")
    # Redirect the home vim config to the repo set
    if os.path.exists(CONFIG_FILE_VIM):
        print(f"'{CONFIG_FILE_VIM}' exists looking to append")
        if find_in_file(CONFIG_FILE_VIM, VIM_PATTERN):
            print(f"'{CONFIG_FILE_VIM}' redirect to repo exists continuing")
        else:
            with open(CONFIG_FILE_VIM, "a") as fa:
                fa.write("\n{0}".format(VIM_PATTERN))
            print(f"'{CONFIG_FILE_VIM}' redirect to repo added")
    else:
        with open(CONFIG_FILE_VIM, "w") as f:
            f.write(VIM_PATTERN)
        print(f"'{CONFIG_FILE_VIM}' file created and redirect to repo set")

def fix_tmux():
    # Test and copy Tmux config
    print("========== TMUX Config ==========")
    CONFIG_FILE_TMUX=f"{HOME}/.tmux.conf"
    PATH_TMUX=f"{LOCAL_REPO}/configs/tmux/tmux.conf"
    try:
        shutil.copy(PATH_TMUX, CONFIG_FILE_TMUX)
        print(f"Copying Tmux config as cannot link to repo to:\n{PATH_TMUX}")
    except Exception as error:
        print("Tmux config.\nError:\n", error)

def fix_i3():
    # Test and copy i3 config
    print("========== I3 Config ==========")
    CONFIG_FILE_I3=f"{HOME}/.config/i3/config"
    PATH_I3=f"{LOCAL_REPO}/configs/i3/config"
    try:
        shutil.copy(PATH_I3, CONFIG_FILE_I3)
        print(f"Copying I3 config as cannot link to repo to:\n{PATH_I3}")
    except Exception as error:
        print("I3 potentially not installed.\nError:\n", error)

def fix_git():
    # Test and copy git config
    print("========== GIT Config ==========")
    CONFIG_FILE_GIT=f"{HOME}/.gitconfig"
    PATH_GIT=f"{LOCAL_REPO}/configs/git/gitconfig"
    PATTERN_GIT= f"\n[include]\npath = {PATH_GIT}"
    if os.path.exists(CONFIG_FILE_GIT):
        if find_in_file(CONFIG_FILE_GIT, PATTERN_GIT):
            print(f"'{CONFIG_FILE_GIT}' redirect exists continuing")
        else:
            with open(CONFIG_FILE_GIT, "a") as f:
                f.write(PATTERN_GIT)
    else:
        with open(CONFIG_FILE_GIT, "a") as f:
            f.write(PATTERN_GIT)

if __name__ == "__main__":

    fix_bash()
    fix_neovim()
    fix_tmux()
    fix_i3()
    fix_git()
