

export XDG_CONFIG_HOME=$HOME/.config
export XINITRC="$XDG_CONFIG_HOME"/X11/xinitrc
export XCURSOR_PATH=/usr/share/icons


# Auto-launch Sway on TTY1 login
if [ "$(tty)" = "/dev/tty1" ]; then
    read -p "Start Sway? [y]es or [n]o: " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        exec dbus-launch --sh-syntax --exit-with-session sway
    fi
fi
