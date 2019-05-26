#!/bin/bash
# Source <[200~https://dotnet.microsoft.com/download/linux-package-manager/ubuntu18-04/sdk-current>
# Install DotNET Core on ubuntu 18.04

function install_dotnet() {
    wget -q https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb
    sudo dpkg -i packages-microsoft-prod.deb


    sudo add-apt-repository universe
    sudo apt-get install apt-transport-https

    sudo apt update
    sudo apt install dotnet-sdk-2.2
}
