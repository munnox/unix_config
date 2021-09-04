# Font

https://github.com/source-foundry/Hack

Copy the font files to either your system font folder (often /usr/share/fonts/) or user font folder (often ~/.local/share/fonts/ or /usr/local/share/fonts).

Copy the font configuration file in `config/fontconfig/` to either the system font configuration folder (often `/etc/fonts/conf.d/`) or the font user folder (often `~/.config/fontconfig/conf.d`)

Clear and regenerate your font cache and indexes with the following command:

`$ fc-cache -f -v`

You can confirm that the fonts are installed with the following command:

`$ fc-list | grep "Hack"`

Some Linux users may find that font rendering is improved on their distro with these instructions.

Or use package manager

```
apt install fonts-hack-ttf
```
