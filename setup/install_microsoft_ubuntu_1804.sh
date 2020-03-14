#!/bin/bash

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
