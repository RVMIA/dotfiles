#!/bin/sh
xrandr --output eDP --primary --mode 2256x1504 --pos 206x1502 --rotate normal --output DisplayPort-0 --off --output DisplayPort-1 --off --output DisplayPort-2 --mode 1920x1080 --pos 0x0 --rotate normal --output DisplayPort-3 --off --output DisplayPort-4 --off --output DisplayPort-5 --off --output DisplayPort-6 --off --output DisplayPort-7 --off
xrandr --output DisplayPort-2 --scale 1.39
nitrogen --restore
