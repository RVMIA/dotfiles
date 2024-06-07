#!/bin/sh
HOST=$(hostname)
XRANDR=$(xrandr -q)

if [[ $HOST = "ame" ]]; then
    xrandr --output DisplayPort-0 --primary --mode 1920x1080 --pos 1920x0 --rotate normal --output HDMI-A-0 --mode 1920x1080 --pos 0x0 --rotate normal &
elif [[ $HOST = "ameFramework" ]]; then
    if xrandr -q | grep -q "DisplayPort-2 connected"; then
        xrandr --output eDP --primary --mode 2256x1504 --pos 206x1502 --rotate normal --output DisplayPort-2 --mode 1920x1080 --pos 0x0 --rotate normal --scale 1.39
    elif xrandr -q | grep -q "DisplayPort-2 disconnected"; then 
                    xrandr --output DisplayPort-2 --off
    fi
else
    arandr &
    disown
fi


