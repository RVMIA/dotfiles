#!/bin/sh

RES=$(slurp)
file="/home/rvmia/Pictures/screenshots/$(date +%s)-screenshot.png"
if [[ $? == 0 ]]; then
    echo $RES | grim -g - $file

    thunar $file 
    wl-copy < $file
fi
