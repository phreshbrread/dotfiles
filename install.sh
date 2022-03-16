#!/bin/bash

while true
do
      read -r -p "Do you want to install the Yay AUR helper? [Y/n] " input
 
      case $input in
            [yY][eE][sS]|[yY])
                  sudo pacman -S --needed git base-devel go
                  cd ~/
                  git clone https://aur.archlinux.org/yay.git
                  cd yay
                  makepkg -si
                  
                  break
                  ;;
            [nN][oO]|[nN])
                  break
                  ;;
            *)
                  echo "Invalid input..."
                  ;;
      esac      
done

yay -S --needed alacritty fish i3-gaps picom polybar nitrogen brightnessctl xautolock rofi thunar google-chrome exa fish arandr neofetch lxappearance nordic-darker-theme papirus-nord nordic-wallpapers

mkdir .config/
cp -r .config/ ~/
mkdir .local/
cp -r .local/ ~/
