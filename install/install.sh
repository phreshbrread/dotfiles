#!/bin/bash

yay -S --needed awesome pa-applet-git ttf-hack font-manager ttf-font-awesome flameshot pacman-contrib alacritty picom polybar onedrive nitrogen brightnessctl rofi dolphin firefox exa fish arandr neofetch lxappearance qbittorrent xterm network-manager-applet polkit-gnome baobab bat gnome-themes-extra lightdm-gtk-greeter lightdm-gtk-greeter-settings ghex github-cli gparted qt5ct-kde tor torbrowser-launcher torsocks blueman dex pa-applet-git breeze breeze-gtk

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
