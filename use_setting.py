#!/usr/bin/env python3
"""
This is a bootstrap script to setup a machine for my use.

The first line allows this script to be run on the bash line with
./use_setting.py
requires `chmod +x foo` to enable execute

Use config settings in python
"""

import os
import shutil
import subprocess

HOME = os.getenv("HOME", None)
PWD = os.path.abspath(".")
LOCAL_REPO = f"{PWD}"
print(LOCAL_REPO)
CONFIG_PATH = os.path.join(LOCAL_REPO, "configs")


def find_in_file(filename, pattern):
    """Look for a pattern in a given file and report"""
    with open(filename, "r") as file_handle:
        if file_handle.read().find(pattern) >= 0:
            return True
    return False


def run_process(*args):
    """Simple wrapper for running a process
    Untested
    """
    sub_process = subprocess.Popen(args)
    sub_process.communicate()


def fix_bash():
    """Install bash config file"""
    # Test and copy BASH config
    print("========== BASH Config ==========")
    bash_pattern = f"source {LOCAL_REPO}/bash/bashrc"
    config_path_bash = f"{HOME}/.bashrc"

    if os.path.exists(config_path_bash):
        print(f"'{config_path_bash}' exists looking to append")
        if find_in_file(config_path_bash, bash_pattern):
            print(f"'{config_path_bash}' redirect exists continuing")
        else:
            with open(config_path_bash, "a") as file_handle:
                file_handle.write("\n{0}".format(bash_pattern))
            print(f"'{config_path_bash}' redirect added")


def fix_neovim():
    """Install neovim config file"""
    # Test and copy NEOVIM
    print("========== NEOVIM Config ==========")
    vim_pattern = f"source {LOCAL_REPO}/configs/vim/vimrc"
    config_file_vim = f"{HOME}/.vimrc"
    config_path_neovim = f"{HOME}/.config/nvim/"
    config_file_neovim = f"{config_path_neovim}/init.vim"

    if os.path.exists(config_path_neovim):
        print(f"'{config_path_neovim}' folder exists")

    else:
        os.mkdir(config_path_neovim)

    # Redirect neovim to the HOME directory vim config
    with open(config_file_neovim, "w") as file_handle:
        file_handle.write("source ~/.vimrc")

    # config_file_vim Test and copy vimrc
    print("========== VIM Config ==========")
    # Redirect the HOME vim config to the repo set
    if os.path.exists(config_file_vim):
        print(f"'{config_file_vim}' exists looking to append")
        if find_in_file(config_file_vim, vim_pattern):
            print(f"'{config_file_vim}' redirect to repo exists continuing")
        else:
            with open(config_file_vim, "a") as file_handle:
                file_handle.write("\n{0}".format(vim_pattern))
            print(f"'{config_file_vim}' redirect to repo added")
    else:
        with open(config_file_vim, "w") as file_handle:
            file_handle.write(vim_pattern)
        print(f"'{config_file_vim}' file created and redirect to repo set")


def fix_tmux():
    """Install tmux config file"""
    # Test and copy Tmux config
    print("========== TMUX Config ==========")
    config_file_tmux = f"{HOME}/.tmux.conf"
    path_tmux = f"{LOCAL_REPO}/configs/tmux/tmux.conf"
    try:
        shutil.copy(path_tmux, config_file_tmux)
        print(f"Copying Tmux config as cannot link to repo to:\n{path_tmux}")
    except Exception as error:  # pylint: disable=broad-except
        print(f"Tmux config.\nError type: ({type(error)}):\n{error}")


def fix_i3():
    """Install i3 window env config file"""
    # Test and copy i3 config
    print("========== I3 Config ==========")
    config_file_i3 = f"{HOME}/.config/i3/config"
    path_i3 = f"{LOCAL_REPO}/configs/i3/config"
    try:
        shutil.copy(path_i3, config_file_i3)
        print(f"Copying I3 config as cannot link to repo to:\n{path_i3}")
        fix_i3status()
    except Exception as error:  # pylint: disable=broad-except
        print(f"I3 potentially not installed.\nError type: ({type(error)}):\n{error}")

def fix_i3status():
    """Install i3 status env config file

    Further info https://i3wm.org/i3status/manpage.html#_external_scripts_programs_with_i3status
    """
    # Test and copy i3 config
    print("========== I3 Config ==========")
    config_path_i3 = f"{HOME}/.config/i3status"
    config_file_i3 = f"{HOME}/config"
    file_i3 = f"{LOCAL_REPO}/configs/i3/i3status.conf"
    try:
        os.mkdir(config_path_i3)
        shutil.copy(file_i3, config_file_i3)
        print(f"Copying I3 config as cannot link to repo to:\n{file_i3}")
    except Exception as error:  # pylint: disable=broad-except
        print(f"I3 potentially not installed.\nError type: ({type(error)}):\n{error}")


def fix_git():
    """Install git config file"""
    # Test and copy git config
    print("========== GIT Config ==========")
    config_file_git = f"{HOME}/.gitconfig"
    path_git = f"{LOCAL_REPO}/configs/git/gitconfig"
    pattern_git = f"\n[include]\npath = {path_git}"
    if os.path.exists(config_file_git):
        if find_in_file(config_file_git, pattern_git):
            print(f"'{config_file_git}' redirect exists continuing")
        else:
            with open(config_file_git, "a") as file_handle:
                file_handle.write(pattern_git)
    else:
        with open(config_file_git, "a") as file_handle:
            file_handle.write(pattern_git)


if __name__ == "__main__":

    fix_bash()
    fix_neovim()
    fix_tmux()
    fix_i3()
    fix_git()
