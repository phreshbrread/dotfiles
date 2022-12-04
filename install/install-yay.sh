#!/bin/bash

while true; do
      read -r -p "Install Yay? [Y/n] " input

      case $input in
      [yY][eE][sS] | [yY])
            sudo pacman -S --needed git base-devel go
            cd ~/
            git clone https://aur.archlinux.org/yay.git
            cd yay
            makepkg -si

            break
            ;;
      [nN][oO] | [nN])
            break
            ;;
      *)
            echo "Invalid input..."
            ;;
      esac
done
