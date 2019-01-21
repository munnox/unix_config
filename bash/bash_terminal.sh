#!/bin/bash

# source ./bash_base_colors.sh
# Color the bash prompt
# PS1=$txtcyn"\h ["$txtpur"\W"$txtcyn"]"$txtrst'$(BRANCH=`git rev-parse --abbrev-ref HEAD 2> /dev/null`; if [ -n "$BRANCH" ]; then DIRTY=`git status --porcelain 2> /dev/null`; if [ -n "$DIRTY" ]; then echo "'$txtylw' ($BRANCH) '$txtrst'"; else echo "'$txtgrn' ($BRANCH) '$txtrst'"; fi fi;)'$txtcyn"\$ "$txtrst

# disable the ctrl-s
stty -ixon
