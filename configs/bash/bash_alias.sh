#!/bin/bash

# ls aliases
alias ll='ls -lah'
alias la='ls -A'
alias l='ls -CF'

# if [ '$DESKTOP_SESSION' = 'ubuntu']; then
# alias ls='ls -alHh --color'
# else
alias lsn='ls -alGHh'
# fi

# alias gitshow='git log --decorate=short --oneline --graph'

alias ssh-ram-config='$EDITOR ~/.ssh/config'

function ssh-ram-helper-config {
  cat << EOF >> ~/.ssh/config

# Further info 'man ssh_config'
# Key seems to be case insensitive
Host dev
  HostName example.com
  User ubuntu
  Port 22
  # IdentityFile ~/.ssh/id_rsa
  # ForwardX11 no

  # Setup a sock v4/v5 proxy set this up in firefox
  # and this then forward all web traffic to the remote server while connected
  # similar to 'ssh -D 8080 dropletA'
  # DynamicForward 8080

  # allow a localhost only port 8000 on remote accessible locally only 
  # similar to 'ssh -L 8000:localhost:8000 dev'
  # Localforward 8000 localhost:8000

  # Force no passwords (optional)
  # PasswordAuthentication no
  # Allow visual finger print (optional)
  # VisualHostKey yes
EOF
}

alias pybuildenv="python3 -m venv pyvenv"
alias pyactivateenv="source pyvenv/bin/activate"
