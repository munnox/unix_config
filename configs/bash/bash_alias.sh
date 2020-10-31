#!/bin/bash

# ls aliases
alias ll='ls -lah'
alias la='ls -A'
alias l='ls -CF'

# tmux aliases
alias tls='tmux ls'
alias tns='tmux new -s'
alias ta='tmux a -t'

# if [ '$DESKTOP_SESSION' = 'ubuntu']; then
# alias ls='ls -alHh --color'
# else
alias lsn='ls -alGHh'
# fi

alias gitshow='git log --decorate=short --oneline --graph'

alias pybuildenv="python3 -m venv pyvenv"
alias pyactivateenv="source pyvenv/bin/activate"
