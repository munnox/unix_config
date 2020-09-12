# Keymaps info

https://wiki.archlinux.org/index.php/Xmodmap#Keymap_table

https://www.linuxquestions.org/questions/linux-general-1/how-can-i-map-the-control-key-to-the-caps-lock-key-in-linux-654155/

https://opensource.com/article/18/11/how-swap-ctrl-and-caps-lock-your-keyboard

https://superuser.com/questions/290115/how-to-change-console-keymap-in-linux

`man xmodmap`

`dumpkeys`
`loadkeys`

```
! clear Lock

! keycode 66 = Hyper_L
! add mod4 = Hyper_L
! keycode 66 = Alt_R
! add Mod4 = Alt_R

! keycode 37 Control_R
! add Mod4 = Control_R

keycode 25 = Control_L
! keycode 55 = Control_R
keycode 32 = Caps_Lock

remove Lock = Caps_Lock
remove Control = Control_L
keysym Control_L = Caps_Lock
keysym Caps_Lock = Control_L
add Lock = Caps_Lock
add Control = Control_L
```

```
# save keys
dumpkeys > backup.kmap
# reload keys
sudo loadkeys backup.kmap
# check the key pressed
showkey
```

## Window

https://superuser.com/questions/949385/map-capslock-to-control-in-windows-10

```
$hexified = "00,00,00,00,00,00,00,00,02,00,00,00,1d,00,3a,00,00,00,00,00".Split(',') | % { "0x$_"};

$kbLayout = 'HKLM:\System\CurrentControlSet\Control\Keyboard Layout';

New-ItemProperty -Path $kbLayout -Name "Scancode Map" -PropertyType Binary -Value ([byte[]]$hexified);
```


## QMK

* https://config.qmk.fm/#/ergodox_ez/LAYOUT_ergodox_pretty

