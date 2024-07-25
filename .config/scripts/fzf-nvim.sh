#!/bin/sh
file=$(alacritty --class 'ame-term' -e fzf -e --scheme=path)
# file=$(fd . '/home/ame' -u | sed "s/^\/home\/ame/\~/" |  awk '{print length " " $1}' | sort -n | sed "s/^[0-9]*\ //;" | dmenu -l 30 | sed "s/^\~/\/home\/ame/")
if [[ -n $file ]]; then
    alacritty -e nvim $file
fi
