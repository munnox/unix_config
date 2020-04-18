
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
DIR="$DIR"
source $DIR/bash_base_colors.sh
# Color the bash prompt
# \u - username
# \h - hostname
# \w - full working directory
# \W - end directory
PROMPT=$bldgrn"\u@\h ["$bldpur"\w"$bldgrn"]"$txtrst'$(BRANCH=`git rev-parse --abbrev-ref HEAD 2> /dev/null`; if [ -n "$BRANCH" ]; then DIRTY=`git status --porcelain 2> /dev/null`; if [ -n "$DIRTY" ]; then echo "'$txtylw' ($BRANCH) '$txtrst'"; else echo "'$txtgrn' ($BRANCH) '$txtrst'"; fi fi;)'$txtcyn"\n\$ "$txtrst
DEFAULT_UBUNTU_PROMPT="\[\e]0;\u@\h: \w\a\]${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$"
# PS1 = ${PS1:-PROMPT}
OLD_PS1=$PS1
export PS1=$PROMPT
