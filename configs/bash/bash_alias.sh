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

alias ssh-config='$EDITOR ~/.ssh/config'

alias pybuildenv="python3 -m venv pyvenv"
alias pyactivateenv="source pyvenv/bin/activate"
