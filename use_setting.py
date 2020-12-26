#!/usr/bin/env python3
"""
This is a bootstrap script to setup a machine for my use.

The first line allows this script to be run on the bash line with
./use_setting.py
requires `chmod +x foo` to enable execute

Use config settings in python
"""

import os
import sys

#  import shutil
import subprocess

HOME = os.getenv("HOME", None)
PWD = os.path.abspath(".")
#  LOCAL_REPO = f"{PWD}"
LOCAL_REPO = os.path.dirname(os.path.abspath(sys.argv[0]))
print(f"Python arguments: {sys.argv},\nLocal repositry path: {LOCAL_REPO}")
CONFIG_PATH = os.path.join(LOCAL_REPO, "configs")

def main():
    print("Installing settings and config\n")

    fix_bash()
    fix_xinit()
    fix_neovim()
    fix_tmux()
    fix_alacritty()
    fix_i3()
    fix_git()


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
    bash_pattern = f"source {CONFIG_PATH}/bash/bashrc"
    config_path_bash = f"{HOME}/.bashrc"

    if os.path.exists(config_path_bash):
        print(f"'{config_path_bash}' exists looking to append")
        if find_in_file(config_path_bash, bash_pattern):
            print(f"'{config_path_bash}' redirect exists continuing")
        else:
            with open(config_path_bash, "a") as file_handle:
                file_handle.write("\n{0}".format(bash_pattern))
            print(f"'{config_path_bash}' redirect added")


def fix_xinit():
    """Install xwin config file"""
    # Test and copy BASH config
    print("========== XWIN Config ==========")
    xsession_pattern = f"{CONFIG_PATH}/xwin/xsession"
    config_path_xsession = f"{HOME}/.xsession"

    try:
        os.symlink(xsession_pattern, config_path_xsession)
        print(f"Linking xinitrc config to:\n{config_path_xsession}")
    except FileExistsError as error:  # pylint: disable=broad-except
        print(f"Already linked")

    xres_pattern = f"{CONFIG_PATH}/xwin/Xresources"
    config_path_xres = f"{HOME}/.Xresources"

    try:
        os.symlink(xres_pattern, config_path_xres)
        print(f"Linking xresources config to:\n{config_path_xres}")
    except FileExistsError as error:  # pylint: disable=broad-except
        print(f"Already linked")

    xmodmap_pattern = f"{CONFIG_PATH}/xwin/xmodmap"
    config_path_xmodmap = f"{HOME}/.xmodmap"

    try:
        os.symlink(xmodmap_pattern, config_path_xmodmap)
        print(f"Linking xmodmap config to:\n{config_path_xmodmap}")
    except FileExistsError as error:  # pylint: disable=broad-except
        print(f"Already linked")


def fix_neovim():
    """Install neovim config file"""
    # Test and copy NEOVIM
    print("========== NEOVIM Config ==========")
    vim_pattern = f"source {CONFIG_PATH}/vim/vimrc"
    config_file_vim = f"{HOME}/.vimrc"
    config_path_neovim = f"{HOME}/.config/nvim/"
    config_file_neovim = f"{config_path_neovim}/init.vim"

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

    if os.path.exists(config_path_neovim):
        print(f"'{config_path_neovim}' folder exists")

    else:
        print(f"'{config_path_neovim}' folder does note exist and need creating")
        # Will make all directories to ensure path is made
        os.makedirs(config_path_neovim)
        # os.mkdir(config_path_neovim)

    # Redirect neovim to the HOME directory vim config
    with open(config_file_neovim, "w") as file_handle:
        file_handle.write("source ~/.vimrc")



def fix_tmux():
    """Install tmux config file"""
    # Test and copy Tmux config
    print("========== TMUX Config ==========")
    config_file_tmux = f"{HOME}/.tmux.conf"
    path_tmux = f"{CONFIG_PATH}/tmux/tmux.conf"
    try:
        os.symlink(path_tmux, config_file_tmux)
        #  shutil.copy(path_tmux, config_file_tmux)
        print(f"Copying Tmux config as cannot link to repo to:\n{path_tmux}")
    except FileExistsError as error:  # pylint: disable=broad-except
        print(f"Already linked")

    except Exception as error:  # pylint: disable=broad-except
        print(f"Tmux config.\nError type: ({type(error)}):\n{error}")


def fix_alacritty():
    """Install alacritty config file"""
    # Test and copy Tmux config
    print("========== ALACRITTY Config ==========")
    config_file_alacritty = f"{HOME}/.config/alacritty/alacritty.yml"
    path_alacritty = f"{CONFIG_PATH}/alacritty/alacritty.yml"
    try:
        os.symlink(path_alacritty, config_file_alacritty)
        #  shutil.copy(path_alacritty, config_file_alacritty)
        print(f"Copying alacritty config as cannot link to repo to:\n{path_alacritty}")
    except FileExistsError as error:  # pylint: disable=broad-except
        print(f"Already linked")

    except Exception as error:  # pylint: disable=broad-except
        print(f"alacritty config.\nError type: ({type(error)}):\n{error}")


def fix_i3():
    """Install i3 config and i3 status env config file

    Further info https://i3wm.org/i3status/manpage.html
    """
    print("========== I3 Config ==========")
    program_found = False
    if os.path.exists("/usr/bin/i3"):
        print("Found I3 binary")
        program_found = True
    else:
        print("Not found I3 binary")
    # Test and copy i3 config
    if not program_found:
        return
    config_file_i3config = f"{HOME}/.config/i3/config"
    path_i3config = f"{CONFIG_PATH}/i3/config"
    try:
        os.symlink(path_i3config, config_file_i3config)
        #  shutil.copy(path_i3, config_file_i3)
        print(f"Copying I3 config as cannot link to repo to:\n{path_i3config}")
    except FileExistsError as error:  # pylint: disable=broad-except
        print(f"Already linked")

    except Exception as error:  # pylint: disable=broad-except
        print(f"I3 potentially not installed.\nError type: ({type(error)}):\n{error}")

    config_path_i3status = f"{HOME}/.config/i3status"
    config_file_i3status = f"{config_path_i3status}/config"
    file_i3status = f"{CONFIG_PATH}/i3/i3status.conf"
    try:
        if not os.path.exists(config_path_i3status):
            os.mkdir(config_path_i3status)
        os.symlink(file_i3status, config_file_i3status)
        #  shutil.copy(file_i3, config_file_i3)
        print(f"Copying I3 status config as cannot link to repo to:\n{file_i3status}")
    except FileExistsError as error:  # pylint: disable=broad-except
        print(f"Already linked")

    except Exception as error:  # pylint: disable=broad-except
        print(f"I3 potentially not installed.\nError type: ({type(error)}):\n{error}")


def fix_git():
    """Install git config file"""
    # Test and copy git config
    print("========== GIT Config ==========")
    config_file_git = f"{HOME}/.gitconfig"
    path_git = f"{CONFIG_PATH}/git/gitconfig"
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
    main()
