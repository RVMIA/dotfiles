#!/bin/sh

if [ -n "$(pidof deadbeef)" ]; then

    artUrl=$(playerctl -p DeaDBeeF metadata mpris:artUrl)
    artName=$(echo $artUrl | sed 's/.*\///').JPEG
    artName="/tmp/$artName"

    artist=$(playerctl -p DeaDBeeF metadata artist)
    song=$(playerctl -p DeaDBeeF metadata title)
    album=$(playerctl -p DeaDBeeF metadata album)


    curl -s $artUrl --output $artName 
    dunstify -t 2000 -I $artName -u low "$song" "$artist - $album" 
    rm $artName

fi
