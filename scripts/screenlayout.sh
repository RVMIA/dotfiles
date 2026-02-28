#!/bin/sh
setxkbmap -option caps:escape
xrandr --output eDP --scale 0.75 --mode 2256x1504 --pos 2580x392 --rotate normal --output DisplayPort-0 --off --output DisplayPort-1 --off --output DisplayPort-2 --primary --mode 3440x1440 -r 100 --scale 0.75 --pos 0x0 --rotate normal --output DisplayPort-3 --off --output DisplayPort-4 --off --output DisplayPort-5 --off --output DisplayPort-6 --off --output DisplayPort-7 --off
sh -c ~/dotfiles/scripts/fehbg.sh
