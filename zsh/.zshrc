# Created by ame for 5.9

# Keybinds
bindkey -e
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line
bindkey "^[[3~" delete-char
bindkey "^H" backward-kill-word
bindkey "5~" kill-word 
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

# Autocomplete
autoload -U compinit 
compinit -d ~/.cache/.zcompdump-$HOST
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b' 
unsetopt correctall

# Environment Variables

## ghcup-env
[ -f "/home/ame/.local/share/ghcup/env" ] && source "/home/ame/.local/share/ghcup/env" 

## Shell History
setopt share_history
setopt inc_append_history_time
HISTFILE=$HOME/.local/state/zsh/history
export HISTSIZE=2000
export SAVEHIST=$HISTSIZE

## GTK Theme
export GTK_THEME='Adwaita:dark'

## Editors
export EDITOR='nvim'
export VISUAL='nvim'

## File Cleanup Misc

### XDG Base Dirs
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share
export XDG_STATE_HOME=$HOME/.local/state


export CABAL_CONFIG=$XDG_CONFIG_HOME/cabal/config
export CABAL_DIR=$XDG_DATA_HOME/cabal
export STACK_ROOT=$XDG_DATA_HOME/stack
export XAUTHORITY=$XDG_RUNTIME_DIR/Xauthority
export ICEAUTHORITY=$XDG_CACHE_HOME/ICEauthority
export GNUPGHOME=$XDG_DATA_HOME/gnupg
export CARGO_HOME=$XDG_DATA_HOME/cargo
export GHCUP_USE_XDG_DIRS=true
export W3M_DIR=$XDG_DATA_HOME/w3m
export RUSTUP_HOME=$XDG_DATA_HOME/rustup
export GOPATH="$XDG_DATA_HOME"/go
export PYTHONSTARTUP="/etc/python/pythonrc"
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java
export DVDCSS_CACHE="$XDG_DATA_HOME"/dvdcss

export NIX_REMOTE=daemon

# PATH
typeset -U path
export PATH='$PATH:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/bin:/usr/lib/llvm/17/bin:/home/ame/.local/bin:/home/ame/.local/share/cargo/bin:/home/ame/.local/bin:/home/ame/.local/share/cargo/bin:/home/ame/.cargo/bin:/home/ame/.local/share/cargo/bin:/var/lib/flatpak/exports/bin:/nix'


# Prompt (Same as gentoo prompt but with a lambda)
PROMPT="%B%F{green}%n@%m%f %F{blue}%~ λ%f%b "
unsetopt PROMPT_CR
unsetopt PROMPT_SP

# aliases
# alias sudo='doas' # need to learn to not rely on sudo tho
alias ls='ls -lAh --color=always'
alias grep='grep --color=always'
alias sz='source $ZDOTDIR/.zshrc'
alias packagelist="equery size '*' | sed 's/\(.*\):.*(\([0-9]*\))$/\2 \1/' | sort -n | numfmt --to=iec-i"
neofetch # run neofetch upon shell startup


