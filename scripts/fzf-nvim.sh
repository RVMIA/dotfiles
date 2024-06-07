#!/bin/sh
# file=$(fzf -e --scheme=path)
# file=$(find ~ | tac | sed "s/^\/home\/ame/\~/" | dmenu -l 10)
file=$(find ~ | tac | sed "s/^\/home\/ame/\~/" | dmenu -l 30 | sed "s/^\~/\/home\/ame/")
if [[ -n $file ]]; then
    alacritty -e nvim $file
fi
