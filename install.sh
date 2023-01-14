#!/bin/bash

read -p "Install configs (y/N)? " choice
case "$choice" in
   y|Y ) cd ~/
         mkdir -p Desktop Documents Downloads Pictures Videos Music
         mkdir -p .config
         mkdir -p .local/share/rofi/themes

         cd ~/dotfiles/
         cp -r config/* ~/.config/
         cp rofi-themes/* ~/.local/share/rofi/themes
         cp .xprofile ~/
         cp .nanorc ~/;;
   n|N ) ;;
   * ) ;;
esac

read -p "Install Yay (y/N)? " choice
case "$choice" in
   y|Y ) sudo pacman -S --needed --noconfirm git base-devel go
         cd ~/
         git clone https://aur.archlinux.org/yay.git
         cd yay
         makepkg -si;;
   n|N ) ;;
   * ) ;;
esac

read -p "Install packages (y/N)? " choice
case "$choice" in
   y|Y ) yay -S --needed --noconfirm $(< pkglist.txt);;
   n|N ) ;;
   * ) ;;
esac
