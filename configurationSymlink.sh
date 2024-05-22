#!/bin/sh
set -xe

ln -s -f ~/dotfiles/ ~/.config/ && rename dotfiles home-manager ~/.config/dotfiles
sudo ln -sf $(find ~/dotfiles/ | grep "configuration.nix") /etc/nixos/configuration.nix
