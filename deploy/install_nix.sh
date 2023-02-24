#!/bin/bash
# VERY opinionated install script and config setup for NIX
# Author Robert Munnoch

if ! [[ -f ~/.config/nix/ ]]; then
    echo "~/.config/nix needs creating"
    mkdir -p ~/.config/nix
else
    echo "~/.config/nix folder exists."
fi
if ! [[ -f ~/.config/nix/nix.conf ]]; then
    echo "nix.conf needs creating"
    cat <<EOF > ~/.config/nix/nix.conf
experimental-features = nix-command flakes
EOF
else
    echo "nix.conf exists"
fi

if ! [[ -f "external_nix_install_script.sh" ]]; then
    echo "Getting nix script"
    # curl -v -L https://nixos.org/nix/install --output external_nix_install_script.sh
    curl -L https://releases.nixos.org/nix/nix-2.11.1/install --output external_nix_install_script.sh
else
    echo "Script found"
#     if [[ $(sha256sum external_nix_install_script.sh) == "4569a01dc5f62056f29f3195673bc3242fc70bf2474927fb5d8549c4d997402d  external_nix_install_script.sh" ]]; then
#         echo "Hash matched"
#     else
#         echo "Hash unmached"
#     fi
fi

TYPE=$1
if [[ $TYPE == "" ]]; then
    TYPE="multi"
fi

echo Type=$TYPE
if [ -x "$(command -v nix)" ]; then
    echo "Nix installed"
else
    echo "Nix not installed"
    # Multiuser (recomended) Current version 2.11.1 @ 2022_11_16
    if [[ $TYPE -eq "multi" ]]; then
        # sh <(curl -L https://nixos.org/nix/install) --daemon
        echo "Multi install"
        sh external_nix_install_script.sh --daemon
    fi
    # # Single non privigled user
    if [[ $TYPE -eq "single" ]]; then
        # sh <(curl -L https://nixos.org/nix/install) --no-daemon
        echo "Single install"
        sh external_nix_install_script.sh --no-daemon
    fi
fi

# if [ -f nix ]; then
# fi

# sudo dnf install -y python3.9 python3-pip
# sudo python3.9 -m pip install poetry
# poetry install
# poetry run ansible-playbook deploy.yml -K
