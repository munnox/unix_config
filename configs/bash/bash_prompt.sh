
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
DIR="$DIR"
source $DIR/bash_base_colors.sh
# Color the bash prompt
PROMPT=$txtcyn"\h ["$txtpur"\W"$txtcyn"]"$txtrst'$(BRANCH=`git rev-parse --abbrev-ref HEAD 2> /dev/null`; if [ -n "$BRANCH" ]; then DIRTY=`git status --porcelain 2> /dev/null`; if [ -n "$DIRTY" ]; then echo "'$txtylw' ($BRANCH) '$txtrst'"; else echo "'$txtgrn' ($BRANCH) '$txtrst'"; fi fi;)'$txtcyn"\$ "$txtrst

# PS1 = ${PS1:-PROMPT}
