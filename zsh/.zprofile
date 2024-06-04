if [[ -o login ]]; then
    [[ -f ~/.config/zsh/.zshrc ]] && source ~/.config/zsh/.zshrc
    [[ -t 0 && $(tty) == /dev/tty1 && -z $DISPLAY ]] && exec startx
else
    exit 1
fi
