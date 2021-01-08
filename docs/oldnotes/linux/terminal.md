# Terminal


Using ANSI OSC 52 escape sequence to cause terminal to store text in the clipboard

* https://en.wikipedia.org/wiki/ANSI_escape_code
* http://ascii-table.com/ansi-escape-sequences.php
* https://www.xfree86.org/4.8.0/ctlseqs.html

further info on term

`infocmp`

```
printf "\033]52;c;$(printf "%s" "blabla" | base64)\a"
