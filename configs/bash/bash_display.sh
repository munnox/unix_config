#!/bin/bash

# alias bright400="echo 400 | sudo tee /sys/class/backlight/intel_backlight/brightness"
# alias bright500="echo 500 | sudo tee /sys/class/backlight/intel_backlight/brightness"
# alias bright900="echo 900 | sudo tee /sys/class/backlight/intel_backlight/brightness"

# alias bright3="xrandr --output eDP-1 --brightness 0.3"
# alias bright5="xrandr --output eDP-1 --brightness 0.5"
# alias bright9="xrandr --output eDP-1 --brightness 0.9"

function brightness {
        echo $1 | sudo tee /sys/class/backlight/intel_backlight/brightness
}

function brightness_xrandr {
        xrandr --output eDP-1 --brightness $1
}

# xps15:
# * min `brightness 0`
# * min real `brightness 1000`
# * max `brightness 120000`
# brightness 5000 && brightness_xrandr 1.0
