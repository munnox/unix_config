# Xrand and DPI

source lost link its from a reddit post

```
#!/usr/bin/env bash

CHARM_CONFIG="/home/user/.PyCharm2017.1/config/colors/me.icls"

# Monitors on NVIDIA GFX
MNL=eDP-1-1
MNDP1=DP-1-1-2
MNDP2=DP-1-2-2
MNHDMI1=HDMI-1-1

# Monitors on Intel GFX
MIL=eDP-1
MIDP1=DP-1-2
MIDP2=DP-2-2
MIHDMI1=HDMI-1

if [ $1 == 'l' ] ; then
    echo "only laptop"
    sed -i -r 's/FONT_SIZE" value="([0-9]+)/FONT_SIZE" value="16/g' $CHARM_CONFIG
    sed -i -r 's/Xft.dpi:.+/Xft.dpi: 90/g' ~/.Xresources
    xrandr --output eDP-1-1 --auto --dpi 90 --output DP-1-1-2 --off --output DP-1-2-2 --off --output HDMI-1-1 --off
elif [ $1 == 'c' ] ; then
    echo "country"
    sed -i -r 's/FONT_SIZE" value="([0-9]+)/FONT_SIZE" value="14/g' $CHARM_CONFIG
    sed -i -r 's/Xft.dpi:.+/Xft.dpi: 90/g' ~/.Xresources
    xrandr --output eDP-1-1 --auto --output HDMI-1-1 --auto --dpi 90 --right-of eDP-1-1
elif [ $1 == 'cc' ] ; then
    echo "country cinema hdmi only"
    sed -i -r 's/FONT_SIZE" value="([0-9]+)/FONT_SIZE" value="12/g' $CHARM_CONFIG
    sed -i -r 's/Xft.dpi:.+/Xft.dpi: 90/g' ~/.Xresources
    xrandr --output eDP-1-1 --off --output HDMI-1-1 --auto --dpi 90 --right-of eDP-1-1
elif [ $1 == 'h' ] ; then
    echo "home"
    sed -i -r 's/FONT_SIZE" value="([0-9]+)/FONT_SIZE" value="16/g' $CHARM_CONFIG
    sed -i -r 's/Xft.dpi:.+/Xft.dpi: 140/g' ~/.Xresources
    xrandr --output eDP-1-1 --auto --dpi 140 --output DP-1-2-2 --mode 3840x2160 --rate 60 --dpi 140 --right-of eDP-1-1 --output DP-1-1-2 --mode 3840x2160 --rate 60 --dpi 140 --right-of DP-1-2-2
elif [ $1 == 'intelh' ] ; then
    echo "home intel 1"
    sed -i -r 's/Xft.dpi:.+/Xft.dpi: 180/g' ~/.Xresources
    xrandr --output "$MIL" --off --output "$MIDP1" --mode 3840x2160 --rate 60 --dpi 180 --output DP-2-2 --mode 3840x2160 --rate 60 --dpi 180 --right-of DP-1-2
fi
xrdb ~/.Xdefaults
xrdb ~/.Xresources
i3 restart
```
