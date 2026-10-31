#! /bin/sh

doas cp -r ~/dotfiles/nix/* /etc/nixos && doas nixos-rebuild switch
