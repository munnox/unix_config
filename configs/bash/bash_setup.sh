#!/bin/sh


setup_install_u1804_dockerce () {
    sudo apt-get update
    sudo apt-get install \
        apt-transport-https \
        ca-certificates \
        curl \
        gnupg2 \
        software-properties-common

    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

    sudo apt-key fingerprint 0EBFCD88

    # Should be "9DC8 5822 9FC7 DD38 854A E2D8 8D81 803C 0EBF CD88"
    echo "Should be \"9DC8 5822 9FC7 DD38 854A E2D8 8D81 803C 0EBF CD88\""

    sudo add-apt-repository \
       "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
	$(lsb_release -cs) stable"

    sudo apt-get update

    sudo apt-get install docker-ce docker-ce-cli containerd.io


}

setup_install_nodejs () {
  curl https://nodejs.org/dist/v14.15.3/$NODE_JS_NAME.tar.xz --output $NODE_JS_NAME.tar.xz
  # Extract and use
  sudo mkdir -p /usr/local/lib/nodejs
  sudo tar -xJvf $NODE_JS_NAME.tar.xz -C /usr/local/lib/nodejs 
}

setup_install_neovim () {
  sudo curl -o /usr/local/bin/nvim -LO https://github.com/neovim/neovim/releases/download/stable/nvim.appimage
  # Make executable
  sudo chmod ugo+x /usr/local/bin/nvim
  sudo ln -s /usr/local/bin/nvim /usr/local/bin/vim
}


setup_install_kvm () {
    sudo apt-get install qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils
    # libvirt-bin provides libvirtd which you need to administer qemu and kvm instances using libvirt

    # qemu-kvm (kvm in Karmic and earlier) is the backend

    # ubuntu-vm-builder powerful command line tool for building virtual machines

    # bridge-utils provides a bridge from your network to the virtual machines
        
    sudo adduser `id -un` libvirt
    sudo adduser `id -un` kvm

    virsh list --all

    sudo apt-get install virt-manager

    # lsmod | grep 8021q

    # enable nested vm's
    sudo touch /etc/modprobe.d/kvm.conf
    echo "options kvm_intel nested=1" | sudo tee -a /etc/modprobe.d/kvm.conf

}


NODE_JS_INSTALLED=0
NODE_JS_VERSION=v14.15.3
NODE_JS_DISTRO=linux-x64
NODE_JS_NAME="node-$NODE_JS_VERSION-$NODE_JS_DISTRO"
NODE_JS_PATH="/usr/local/lib/nodejs/$NODE_JS_NAME"

# set PATH so it includes user's private bin if it exists
if [ -d "$NODE_JS_PATH/bin" ] ; then
    NODE_JS_INSTALLED=1
    PATH="$NODE_JS_PATH/bin:$PATH"
fi


