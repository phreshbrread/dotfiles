#!/bin/bash

while true; do
      read -r -p "Would you like to install the Yay AUR helper? [Y/n] " input

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

yay -S --needed alacritty fish i3-gaps i3status i3lock picom polybar onedriver nitrogen brightnessctl xautolock rofi nemo google-chrome exa fish arandr neofetch lxappearance qbittorrent dmenu xterm xpad network-manager-applet polkit-gnome baobab bat gnome-themes-extra lightdm-gtk-greeter lightdm-gtk-greeter-settings

cd ~/
mkdir Desktop/ Documents/ Downloads/ Pictures/ Videos/ Music/
mkdir Pictures/Wallpapers/
mkdir .config/
mkdir -p .local/share/rofi/themes/

cp -r .config/* ~/.config
cp wallpapers/* ~/Pictures/Wallpapers
cp rofi-themes/* ~/.local/share/rofi/themes

while true; do
      read -r -p "Would you like to enable LightDM? [Y/n] " input

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
