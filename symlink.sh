#!/bin/sh

set -x

ln -s -T /home/ame/dotfiles/xmonad ~/.config/xmonad 
ln -s -T /home/ame/dotfiles/rofi ~/.config/rofi 
ln -s -T /home/ame/dotfiles/zsh ~/.config/zsh 
ln -s -T /home/ame/dotfiles/alacritty ~/.config/alacritty
ln -s -T /home/ame/dotfiles/nvim ~/.config/nvim
ln -s -T /home/ame/dotfiles/zathura ~/.config/zathura
ln -s -T /home/ame/dotfiles/neofetch ~/.config/neofetch
ln -s -T /home/ame/dotfiles/sway ~/.config/sway

ln -s -T /home/ame/dotfiles/.Xdefaults ~/.Xdefaults
doas ln -s -T /home/ame/dotfiles/dmenu-5.3 /etc/portage/savedconfig/x11-misc/dmenu-5.3

# Change this out with any other WM
ln -s -T /home/ame/dotfiles/xinitrc ~/.xinitrc
