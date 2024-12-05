#!/bin/sh
manpage=$(man -k . | dmenu -l 30 | awk '{print $1}' )
if [[ -n $manpage ]]; then
    man -Tpdf $manpage | zathura --fork -
fi
