# Terminal colors

Some digging has turned up some very useful information on terminal color schemes

* [first source](https://stackoverflow.com/questions/4842424/list-of-ansi-color-escape-sequences)
* [wiki article](https://en.wikipedia.org/wiki/ANSI_escape_code)

## ANSI colours

`bash colour.sh` is a simple bash script to print out the colour range

## Vim colors

```
:hi <group> ctermbg=235 guibg=#403D3D
```

## Bash color variables

``` {.bash}
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
```

## Bash prompt

Bash manual for the prompt is at <https://www.gnu.org/software/bash/manual/bashref.html#Controlling-the-Prompt>

```
\a
A bell character.

\d
The date, in "Weekday Month Date" format (e.g., "Tue May 26").

\D{format}
The format is passed to strftime(3) and the result is inserted into the prompt string; an empty format results in a locale-specific time representation. The braces are required.

\e
An escape character.

\h
The hostname, up to the first ‘.’.

\H
The hostname.

\j
The number of jobs currently managed by the shell.

\l
The basename of the shell’s terminal device name.

\n
A newline.

\r
A carriage return.

\s
The name of the shell, the basename of $0 (the portion following the final slash).

\t
The time, in 24-hour HH:MM:SS format.

\T
The time, in 12-hour HH:MM:SS format.

\@
The time, in 12-hour am/pm format.

\A
The time, in 24-hour HH:MM format.

\u
The username of the current user.

\v
The version of Bash (e.g., 2.00)

\V
The release of Bash, version + patchlevel (e.g., 2.00.0)

\w
The current working directory, with $HOME abbreviated with a tilde (uses the $PROMPT_DIRTRIM variable).

\W
The basename of $PWD, with $HOME abbreviated with a tilde.

\!
The history number of this command.

\#
The command number of this command.

\$
If the effective uid is 0, #, otherwise $.

\nnn
The character whose ASCII code is the octal value nnn.

\\
A backslash.

\[
Begin a sequence of non-printing characters. This could be used to embed a terminal control sequence into the prompt.

\]
End a sequence of non-printing characters.
```
