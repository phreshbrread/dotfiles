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

yay -S --needed colorpicker font-manager ttf-font-awesome pacman-contrib alacritty i3-gaps i3status i3lock picom polybar onedrive nitrogen brightnessctl xautolock rofi dolphin brave-bin exa fish arandr neofetch lxappearance qbittorrent dmenu xterm xpad network-manager-applet polkit-gnome baobab bat gnome-themes-extra lightdm-gtk-greeter lightdm-gtk-greeter-settings flameshot ghex github-cli gparted qt5ct tor torbrowser-launcher torsocks adwaita-qt5 blueman

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
