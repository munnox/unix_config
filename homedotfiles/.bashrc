#!/bin/bash

# aliases
alias ll='ls -lah'

# if [ '$DESKTOP_SESSION' = 'ubuntu']; then
# alias ls='ls -alHh --color'
# else
alias lsn='ls -alGHh'
# fi

alias gitshow='git log --decorate=short'

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

# Colours
txtblk='\[\e[0;30m\]' # Black - Regular
txtred='\[\e[0;31m\]' # Red
txtgrn='\[\e[0;32m\]' # Green
txtylw='\[\e[0;33m\]' # Yellow
txtblu='\[\e[0;34m\]' # Blue
txtpur='\[\e[0;35m\]' # Purple
txtcyn='\[\e[0;36m\]' # Cyan
txtwht='\[\e[0;37m\]' # White

bldblk='\[\e[1;30m\]' # Black - Bold
bldred='\[\e[1;31m\]' # Red
bldgrn='\[\e[1;32m\]' # Green
bldylw='\[\e[1;33m\]' # Yellow
bldblu='\[\e[1;34m\]' # Blue
bldpur='\[\e[1;35m\]' # Purple
bldcyn='\[\e[1;36m\]' # Cyan
bldwht='\[\e[1;37m\]' # White

unkblk='\[\e[4;30m\]' # Black - Underline
undred='\[\e[4;31m\]' # Red
undgrn='\[\e[4;32m\]' # Green
undylw='\[\e[4;33m\]' # Yellow
undblu='\[\e[4;34m\]' # Blue
undpur='\[\e[4;35m\]' # Purple
undcyn='\[\e[4;36m\]' # Cyan
undwht='\[\e[4;37m\]' # White

bakblk='\[\e[40m\]'   # Black - Background
bakred='\[\e[41m\]'   # Red
badgrn='\[\e[42m\]'   # Green
bakylw='\[\e[43m\]'   # Yellow
bakblu='\[\e[44m\]'   # Blue
bakpur='\[\e[45m\]'   # Purple
bakcyn='\[\e[46m\]'   # Cyan
bakwht='\[\e[47m\]'   # White
txtrst='\[\e[0m\]'    # Text Reset

# Color the bash prompt
PS1=$txtcyn"\h ["$txtpur"\W"$txtcyn"]"$txtrst'$(BRANCH=`git rev-parse --abbrev-ref HEAD 2> /dev/null`; if [ -n "$BRANCH" ]; then DIRTY=`git status --porcelain 2> /dev/null`; if [ -n "$DIRTY" ]; then echo "'$txtylw' ($BRANCH) '$txtrst'"; else echo "'$txtgrn' ($BRANCH) '$txtrst'"; fi fi;)'$txtcyn"\$ "$txtrst

export VISUAL=code
export EDITOR=vim
# # git branch autocompletion
# if [ -f ~/dotfiles/.git-completion.bash ]; then
#   . ~/dotfiles/.git-completion.bash
# fi
