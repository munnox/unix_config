#!/bin/bash

sudo dnf install -y python3.9 python3-pip
sudo python3.9 -m pip install poetry
poetry install
poetry run ansible-playbook deploy.yml -K
