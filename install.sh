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

yay -S --needed awesome pa-applet-git ttf-hack font-manager ttf-font-awesome flameshot pacman-contrib alacritty picom polybar onedrive nitrogen brightnessctl xautolock rofi dolphin firefox exa fish arandr neofetch lxappearance qbittorrent xterm network-manager-applet polkit-gnome baobab bat gnome-themes-extra lightdm-gtk-greeter lightdm-gtk-greeter-settings ghex github-cli gparted qt5ct-kde tor torbrowser-launcher torsocks adwaita-qt5 blueman

while true; do
      read -r -p "Enable LightDM? [Y/n] " input

      case $input in
      [yY][eE][sS] | [yY])
            sudo systemctl enable lightdm.service

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
