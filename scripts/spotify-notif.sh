#!/bin/sh

if [ -n "$(pidof spotify)" ]; then

    artUrl=$(playerctl -p spotify metadata mpris:artUrl)
    artName=$(echo $artUrl | sed 's/.*\///').JPEG
    artName="/tmp/$artName"

    artist=$(playerctl -p spotify metadata artist)
    song=$(playerctl -p spotify metadata title)
    album=$(playerctl -p spotify metadata album)


    curl -s $artUrl --output $artName 
    dunstify -t 2000 -I $artName -u low "$song" "$artist - $album" 
    rm $artName

fi
