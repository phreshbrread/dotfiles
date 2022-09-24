#!/bin/bash

cd ~/
mkdir -p Desktop Documents Downloads Pictures Videos Music
mkdir -p Pictures/Wallpapers
mkdir -p .config
mkdir -p .local/share/rofi/themes
mkdir -p .cargo/env

cd ~/dotfiles/
cp -r .config/* ~/.config/
cp wallpapers/* ~/Pictures/Wallpapers
cp rofi-themes/* ~/.local/share/rofi/themes
cp .profile  ~/
cp .xprofile ~/
