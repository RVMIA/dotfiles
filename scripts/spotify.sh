#!/bin/sh

if [ -n "$(pidof deadbeef)" ]; then
    if [ "$(playerctl -p DeaDBeeF status | grep -v Stopped)" ]; then
        pause="⏸️"
        play="▶️"
        # play=$(echo -e '\uf2e1')

        artist=$(playerctl -p DeaDBeeF metadata artist)
        song=$(playerctl metadata title -p DeaDBeeF)
        artist="${artist:0:30}"
        song="${song:0:30}"

        position=$(playerctl -p DeaDBeeF position | cut -f 1 -d '.')
        status=$(playerctl -p DeaDBeeF status | sed "s/Paused/$pause/;s/Playing/$play/")
        length=$(playerctl -p DeaDBeeF metadata mpris:length | sed 's/.\{6\}$//')
        percent=$((position * 100 / length))
        
        echo -n "$status $artist - $song - $percent%"
        # echo -n "<action=\`./dotfiles/scripts/DeaDBeeF-notif.sh\`>$status</action> $percent%"
    fi
fi
