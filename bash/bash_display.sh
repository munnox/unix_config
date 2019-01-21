#!/bin/bash

alias bright400="echo 400 | sudo tee /sys/class/backlight/intel_backlight/brightness"
alias bright500="echo 500 | sudo tee /sys/class/backlight/intel_backlight/brightness"
alias bright900="echo 900 | sudo tee /sys/class/backlight/intel_backlight/brightness"

alias bright3="xrandr --output eDP-1 --brightness 0.3"
alias bright5="xrandr --output eDP-1 --brightness 0.5"
alias bright9="xrandr --output eDP-1 --brightness 0.9"

