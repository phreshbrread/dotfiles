#!/bin/bash

read -p "Install configs (y/N)? " choice
case "$choice" in
   y|Y ) cd ~/
         mkdir -p Desktop Documents Downloads Pictures Videos Music
         mkdir -p .config
         mkdir -p .local/share/rofi/themes
         #mkdir -p .cargo/env

         cd ~/dotfiles/
         cp -r config/* ~/.config/
         cp rofi-themes/* ~/.local/share/rofi/themes
         #cp .profile  ~/
         cp .xprofile ~/;;
   n|N ) ;;
   * ) ;;
esac

read -p "Install Lightdm slick greeter (y/N)? " choice
case "$choice" in
   y|Y ) sudo pacman -S --needed lightdm-slick-greeter lightdm-settings
         sudo sed -i 's/#greeter-session=example-gtk-greeter/greeter-session=lightdm-slick-greeter/g' /etc/lightdm/lightdm.conf;;
   n|N ) ;;
   * ) ;;
esac

read -p "Install Yay (y/N)? " choice
case "$choice" in
   y|Y ) sudo pacman -S --needed git base-devel go
         cd ~/
         git clone https://aur.archlinux.org/yay.git
         cd yay
         makepkg -si;;
   n|N ) ;;
   * ) ;;
esac

read -p "Install packages (y/N)? " choice
case "$choice" in
   y|Y ) yay -S --needed $(< pkglist.txt);;
   n|N ) ;;
   * ) ;;
esac
