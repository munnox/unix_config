#!/bin/bash

if  [[ -f ~/.config/nix ]]; then
    echo "~/.config/nix needs creating"
    mkdir ~/.config/nix
fi
cat <<EOF > ~/.config/nix.conf
experimental-features = nix-command flakes
EOF

if [ -x "$(command -v nix)" ]; then
    echo "Nix installed"
else
    echo "Nix not installed"
    # Multiuser (recomended) Current version 2.6.1 @ 2022_02_25
    sh <(curl -L https://nixos.org/nix/install) --daemon
    # # Single non privigled user
    # sh <(curl -L https://nixos.org/nix/install) --no-daemon
fi

# if [ -f nix ]; then
# fi

# sudo dnf install -y python3.9 python3-pip
# sudo python3.9 -m pip install poetry
# poetry install
# poetry run ansible-playbook deploy.yml -K
