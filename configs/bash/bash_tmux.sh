#!/bin/bash

# lists the current sessions
alias tmuxls='tmux list-sessions'
# attaches to the session specified
alias tmuxas='tmux attach-session -t'
# Creates or attaches to the current session
alias tmuxns='tmux new-session -A -s'
# as an adendum the the main key are bound to Ctrl-B
# % makes another vertical window
# " makes another window top and bottom
# left and right moves the current windows
# & kill the current window
# d detach from current session
# $ rename current sessionc

# tmux aliases
alias tls='tmux ls'
alias tns='tmux new -s'
alias ta='tmux a -t'


