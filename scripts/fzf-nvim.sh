#!/bin/sh
file=$(fzf -e --scheme=path)
if [[ -n $file ]]; then
    nvim $file
fi
