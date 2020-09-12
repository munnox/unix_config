# https://unix.stackexchange.com/questions/267885/how-do-i-scale-i3-window-manager-for-my-hidpi-display
# 
# Other possible solution
# cvt 3840 2160 60
# // Output: -> Modeline "3840x2160_60.00"  712.75  3840 4160 4576 5312  2160 2163 2168 2237 -hsync +vsync
#
# xrandr --newmode "3840x2160_60.00"  3840x2160_60.00"  712.75  3840 4160 4576 5312  2160 2163 2168 2237 -hsync +vsync
# xrandr --addmode VGA-1 3840x2160_60.00
#
# xrandr -s 3840x2160
# 
# https://askubuntu.com/questions/377937/how-to-set-a-custom-resolution
#
#
# setup for high dpi
# xrandr --dpi 220
setxkbmap gb

xmodmap ~/.modmap

xrdb -merge ~/.xresources
exec i3
