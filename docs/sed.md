# SED

source https://www.grymoire.com/Unix/Sed.html#uh-0

example:

```
sed s/day/night/ <old >new
sed s/day/night/ old >new
echo day | sed s/day/night/
```

Source https://www.benmccann.com/sed-cookbook/

* You need a backslash before parens in a regex grouping
* You refer to matched regex groups using \1, \2, etc.
* The + regex operator does not work
* Non-greedy quantifiers don’t work.  For example, .*? will not work
* The output is printed to standard out by default.  You need the -i option if you want to edit a file with sed.

Strip trailing whitespace from a file

`sed -i -e 's/ *$//'`

Remove the first line of a stream

`sed '1d'`

Recursively replace tabs with spaces

`grep -Plr '\t' src/ | xargs sed -i 's/\t/  /g'`

