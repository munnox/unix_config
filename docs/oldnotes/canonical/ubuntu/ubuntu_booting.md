# Ubuntu GRUB booting

Starting the machine in text console

Source <https://askubuntu.com/questions/859630/how-to-start-ubuntu-in-console-mode>


Boot into recovery mode

on boot hit Shift or ESC if UEFI

Edit `/etc/default/grub`

Add

```
GRUB_CMDLINE_LINUX_DEFAULT="text"
GRUB_TERMINAL=console
```

then run

```
sudo update-grub
sudo systemctl set-default multi-user.target
```

Undo...

`sudo systemctl set-default graphical.target`
