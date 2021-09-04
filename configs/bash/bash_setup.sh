#!/bin/sh

# =========================== DOCKER =============================
# Source <https://docs.docker.com/install/linux/docker-ce/ubuntu/>
# Install Docker CE on linux
#
# Covenience script
# curl -fsSL https://get.docker.com -o get-docker.sh

function setup_install_u1804_dockerce() {
    sudo apt-get update
    sudo apt-get upgrade -y
    sudo apt-get install apt-transport-https ca-certificates curl gnupg2 software-properties-common

    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

    # The finger print should be "9DC8 5822 9FC7 DD38 854A E2D8 8D81 803C 0EBF CD88"
    # the following checks this and returns if wrong
    (sudo apt-key fingerprint 0EBFCD88 | grep "9DC8 5822 9FC7 DD38 854A  E2D8 8D81 803C 0EBF CD88"
    if [ "$?" -eq 0 ]; then
        echo "Fingerprint OK to continue"
    else
        echo "Failed fingerprint"
        return
    fi)

    sudo add-apt-repository \
       "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

    sudo apt-get update
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose
    sudo usermod -aG docker $USER
}

# =========================== DOCKER =============================
# Source <https://techviewleo.com/install-docker-and-docker-compose-on-rocky-linux/>
# Source <>
# Install Docker CE on linux
#
# Covenience script
# curl -fsSL https://get.docker.com -o get-docker.sh

function setup_install_rocky_dockerce() {
    sudo dnf update -y
    sudo dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo


    # sudo yum install -y yum-utils
    # sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

    # sudo dnf install docker-ce --allowerassing
    sudo dnf install docker-ce docker-ce-cli containerd.io
    # If you encounter a containerd.io error, use command below to bypass the error.
    # sudo dnf install docker-ce docker-ce-cli containerd.io docker-compose --allowerassing

    # https://devcoops.com/how-to-install-docker-compose-on-rocky-linux/
    # sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    # sudo chmod +x /usr/local/bin/docker-compose
    # sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
    # docker-compose --version

    sudo usermod -aG docker $USER
}

NODE_JS_INSTALLED=0
NODE_JS_VERSION=v14.17.6
NODE_JS_DISTRO=linux-x64
NODE_JS_NAME="node-$NODE_JS_VERSION-$NODE_JS_DISTRO"
NODE_JS_PATH="/usr/local/lib/nodejs/$NODE_JS_NAME"

# set PATH so it includes user's private bin if it exists
if [ -d "$NODE_JS_PATH/bin" ] ; then
    NODE_JS_INSTALLED=1
    PATH="$NODE_JS_PATH/bin:$PATH"
fi

setup_install_nodejs () {
  # see above set env variable and the path if found
  curl https://nodejs.org/dist/$NODE_JS_VERSION/$NODE_JS_NAME.tar.xz --output $NODE_JS_NAME.tar.xz
  # Extract and use
  sudo mkdir -p /usr/local/lib/nodejs
  sudo tar -xJvf $NODE_JS_NAME.tar.xz -C /usr/local/lib/nodejs
}


setup_install_neovim () {
  sudo curl -o /usr/local/bin/nvim -LO https://github.com/neovim/neovim/releases/download/stable/nvim.appimage
  # Make executable
  sudo chmod ugo+x /usr/local/bin/nvim
  sudo ln -s /usr/local/bin/nvim /usr/local/bin/vim
  # ./nvim.appimage --appimage-extract
  # ./squashfs-root/usr/bin/nvim
}

# =================== Ansible =======================================
# Source <https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html?extIdCarryOver=true&sc_cid=701f2000001OH7YAAW#latest-releases-via-apt-ubuntu>
# Install Ansible on ubuntu 18.04

function setup_install_ansible() {
    sudo apt update
    sudo apt install software-properties-common
    sudo apt-add-repository --yes --update ppa:ansible/ansible
    sudo apt install ansible
}

function setup_install_python_ansible() {
   sudo apt install python3 python-venv python3-pip
   sudo pip3 install ansible
}

# ======================== KVM Ubuntu 18.04/20.04 =========================
# source https://help.ubuntu.com/community/KVM/Installation

function setup_install_kvm() {
    sudo apt-get install qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils

    # libvirt-bin provides libvirtd which you need to administer qemu and kvm instances using libvirt
    # qemu-kvm (kvm in Karmic and earlier) is the backend
    # ubuntu-vm-builder powerful command line tool for building virtual machines
    # bridge-utils provides a bridge from your network to the virtual machines

    sudo adduser `id -un` libvirt
    sudo adduser `id -un` kvm

    virsh list --all

    sudo apt-get install virt-manager

    # VLANs
    # lsmod | grep 8021q

    # enable nested vm's
    sudo touch /etc/modprobe.d/kvm.conf
    echo "options kvm_intel nested=1" | sudo tee -a /etc/modprobe.d/kvm.conf

}

# ======================== VirtualBox =========================
# source https://www.virtualbox.org/wiki/Linux_Downloads

function setup_install_virtualbox() {
    wget https://download.virtualbox.org/virtualbox/6.1.26/virtualbox-6.1_6.1.26-145957~Ubuntu~eoan_amd64.deb

    sudo apt install ./virtualbox-6.1_6.1.26-145957~Ubuntu~eoan_amd64.deb

}

function setup_install_podman() {
    # Source https://podman.io/getting-started/installation
    . /etc/os-release
    echo "deb https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/xUbuntu_${VERSION_ID}/ /" | sudo tee /etc/apt/sources.list.d/devel:kubic:libcontainers:stable.list
    curl -L https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/xUbuntu_${VERSION_ID}/Release.key | sudo apt-key add -
    sudo apt-get update
    sudo apt-get -y upgrade
    sudo apt-get -y install podman
}

# ======================== RUST Ubuntu 18.04/20.04 =========================
# Source <https://www.rust-lang.org/tools/install>
# Install Docker CE on linux

function setup_install_rust() {
    # useful programs
    # sudo apt install git tmux neovim gcc
    # Required program
    if command -v apt &> /dev/null
    then
        echo "apt found assuming debian"
        sudo apt install curl
    fi
    if command -v dnf &> /dev/null
    then
        echo "dng found assuming centos or rocky"
        sudo dnf install curl
    fi
    curl https://sh.rustup.rs -sSf | sh
}

function setup_install_alacritty {
    # Original source https://gist.github.com/Aaronmacaron/8a4e82ed0033290cb2e12d9df4e77efe
    #!/bin/bash
    sudo snap install alacritty --edge --classic
    mkdir -p ~/.config/alacrity/

    # # This installs alacritty terminal on ubuntu (https://github.com/jwilm/alacritty)
    # # You have to have rust/cargo installed for this to work

    # # Install required tools
    # sudo apt-get install cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev python3

    # # Download, compile and install Alacritty
    # git clone https://github.com/alacritty/alacritty.git
    # cd alacritty
    # cargo build --release
    # cargo install

    # # Add Man-Page entries
    # sudo mkdir -p /usr/local/share/man/man1
    # gzip -c alacritty.man | sudo tee /usr/local/share/man/man1/alacritty.1.gz > /dev/null

    # # Terminfo
    # sudo tic -xe alacritty,alacritty-direct extra/alacritty.info

    # # Add shell completion for bash and zsh
    # mkdir -p ~/.bash_completion
    # cp alacritty-completions.bash ~/.bash_completion/alacritty
    # echo "source ~/.bash_completion/alacritty" >> ~/.bashrc

    # # Copy default config into home dir
    # cp alacritty.yml ~/.alacritty.yml

    # # Create desktop file
    # cp Alacritty.desktop ~/.local/share/applications/

    # # Copy binary to path
    # sudo cp target/release/alacritty /usr/local/bin

    # # Use Alacritty as default terminal (Ctrl + Alt + T)
    # gsettings set org.gnome.desktop.default-applications.terminal exec 'alacritty'

    # # # Remove temporary dir
    # # cd ..
    # # rm -r alacritty

}

# ======================== dotnet Ubuntu 18.04/20.04 =========================
function install_dotnet() {
    # Source https://dotnet.microsoft.com/download/linux-package-manager/ubuntu18-04/sdk-current
    # Install DotNET Core on ubuntu 18.04

    # Download the Microsoft repository GPG keys
    wget -q https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb

    # Register the Microsoft repository GPG keys
    sudo dpkg -i packages-microsoft-prod.deb

    # Enable the "universe" repositories
    sudo add-apt-repository universe

    sudo apt-get install apt-transport-https

    # Update the list of products
    sudo apt update

    # Install Dotnet Core
    sudo apt install dotnet-sdk-2.2
}

function install_powershell() {
    # Source https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell-core-on-linux?view=powershell-7
    # Install Powershell on ubuntu 18.04

    # Download the Microsoft repository GPG keys
    wget -q https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb

    # Register the Microsoft repository GPG keys
    sudo dpkg -i packages-microsoft-prod.deb

    # Update the list of products
    sudo apt-get update

    # Enable the "universe" repositories
    sudo add-apt-repository universe

    # Install PowerShell
    sudo apt-get install -y powershell

    # # Start PowerShell
    # pwsh
}
