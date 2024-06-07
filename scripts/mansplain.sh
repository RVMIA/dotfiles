#!/bin/sh
manpage=$(man -k . | fzf -e | awk '{print $1}' )
if [[ -n $manpage ]]; then
    man -Tpdf $manpage | zathura --fork -
fi
