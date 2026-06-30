#! /usr/bin/env bash

doas cp -r ~/dotfiles/nix/* /etc/nixos && doas nixos-rebuild switch
