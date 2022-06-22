
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

yay -S --needed ttf-font-awesome pacman-contrib alacritty fish i3-gaps i3status i3lock picom polybar onedriver nitrogen brightnessctl xautolock rofi nemo brave-bin exa fish arandr neofetch lxappearance qbittorrent dmenu xterm xpad network-manager-applet polkit-gnome baobab bat gnome-themes-extra lightdm-gtk-greeter lightdm-gtk-greeter-settings flameshot ghex github-cli gparted qt5ct tor torbrowser-launcher torsocks adwaita-qt5

cd ~/
mkdir -p Desktop Documents Downloads Pictures Videos Music
mkdir -p Pictures/Wallpapers
mkdir -p .config
mkdir -p .local/share/rofi/themes

cd ~/dotfiles/
cp -r .config ~/
cp wallpapers/* ~/Pictures/Wallpapers
cp rofi-themes/* ~/.local/share/rofi/themes
cp .profile  ~/

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
