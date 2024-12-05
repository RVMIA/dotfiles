#!/bin/sh

set -xe

HOST=$(hostname)
DISPLAYS=$(xrandr -q | grep --color=never -e '[0-9] con' | cut -d' ' -f1-2)
if [[ $HOST = "ame" ]]; then
    xrandr \
        --output DisplayPort-0 --primary --mode 1920x1080 --pos 1920x0 --rotate normal \
        --output HDMI-A-0 --mode 1920x1080 --pos 0x0 --rotate normal 
elif [[ $HOST = "ameFramework" ]]; then
    if echo $DISPLAYS | grep -q "2"; then
        xrandr \
            --output eDP --primary --mode 2256x1504 --pos -168x1080 --rotate normal \
            --output DisplayPort-2 --mode 1920x1080 --pos 0x0 --rotate normal

    elif echo $DISPLAYS | grep -q "\(8\|9\)"; then 
        xrandr \
            --output DisplayPort-8 --mode 1920x1080 --pos 1920x0 --rotate normal \
            --output DisplayPort-9 --mode 1920x1080 --pos 0x0 --rotate normal --primary \
            --output eDP --off
    elif echo $DISPLAYS | grep -q "\(10\|11\)"; then 
        xrandr \
            --output DisplayPort-10 --mode 1920x1080 --pos 1920x0 --rotate normal \
            --output DisplayPort-11 --mode 1920x1080 --pos 0x0 --rotate normal --primary \
            --output eDP --off
    else
        xset +dpms
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
xset dpms 0 0 0 && xset s noblank  && xset s off &
sh -c "~/dotfiles/scripts/fehbg.sh" &
setxkbmap -option caps:escape &
