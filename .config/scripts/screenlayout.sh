#!/bin/sh
HOST=$(hostname)
XRANDR=$(xrandr -q)

if [[ $HOST = "ame" ]]; then
    xrandr \
        --output DisplayPort-0 --primary --mode 1920x1080 --pos 1920x0 --rotate normal \
        --output HDMI-A-0 --mode 1920x1080 --pos 0x0 --rotate normal 
elif [[ $HOST = "ameFramework" ]]; then
    if xrandr -q | grep -q "DisplayPort-2 connected"; then
        xrandr \
            --output eDP --primary --mode 2256x1504 --pos -168x1080 --rotate normal \
            --output DisplayPort-2 --mode 1920x1080 --pos 0x0 --rotate normal

    elif xrandr -q | grep -q "DisplayPort-8 connected"; then 
        xrandr \
            --output DisplayPort-8 --primary --mode 1920x1080 --pos 1920x0 --rotate normal \
            --output DisplayPort-9 --mode 1920x1080 --pos 0x0 --rotate normal \
            --output eDP --off
    elif xrandr -q | grep -q "DisplayPort-10 connected"; then 
        xrandr \
            --output DisplayPort-10 --primary --mode 1920x1080 --pos 1920x0 --rotate normal \
            --output DisplayPort-11 --mode 1920x1080 --pos 0x0 --rotate normal \
            --output eDP --off
    else
        xrandr \
            --output eDP --mode 2256x1504 --pos 0x0 --rotate normal \
            --output DisplayPort-2 --off \
            --output DisplayPort-8 --off \
            --output DisplayPort-9 --off \
            --output DisplayPort-10 --off \
            --output DisplayPort-11 --off
    fi  
else
    arandr &
    disown
fi
sh -c "./fehbg.sh"
setxkbmap -option caps:escape
