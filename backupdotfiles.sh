#! /bin/bash

# Todo use variables for dotfiles paths

rm -r ~/dotfiles/config/*
rm ~/dotfiles/rofi-themes/*


cp -r ~/.config/i3 ~/dotfiles/config/
cp -r ~/.config/fish ~/dotfiles/config/
cp -r ~/.config/polybar ~/dotfiles/config/
cp -r ~/.config/awesome ~/dotfiles/config/
cp -r ~/.config/neofetch ~/dotfiles/config/
cp -r ~/.config/alacritty ~/dotfiles/config/

cp ~/.local/share/rofi/themes/* ~/dotfiles/rofi-themes/

cp ~/.xprofile ~/dotfiles/
cp ~/.nanorc ~/dotfiles/
