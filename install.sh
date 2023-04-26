#!/bin/bash

read -p "Install configs (y/n)? " choice
case "$choice" in
   y|Y ) cd ~/
         mkdir -p Desktop Documents Downloads Pictures Videos Music
         mkdir -p .config
         mkdir -p .local/share/rofi/themes

         cd ~/dotfiles/
         cp -r config/* ~/.config/
         cp rofi-themes/* ~/.local/share/rofi/themes
         cp .xprofile ~/
         cp .profile ~/
         cp .nanorc ~/;;
   n|N ) ;;
   * ) ;;
esac

read -p "Enable chaotic AUR (y/n)? " choice
case "$choice" in
   y|Y ) pacman-key --recv-key FBA220DFC880C036 --keyserver keyserver.ubuntu.com
         pacman-key --lsign-key FBA220DFC880C036
         pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'
         echo "Append"
         echo "'[chaotic-aur]"
         echo "Include = /etc/pacman.d/chaotic-mirrorlist'"
         echo "to the end of /etc/pacman.conf"
         echo ""
         echo "Remember to update mirrors";;
   n|N ) ;;
   * ) ;;
esac


read -p "Install Yay (y/n)? " choice
case "$choice" in
   y|Y ) sudo pacman -S --needed --noconfirm git base-devel go
         cd ~/
         git clone https://aur.archlinux.org/yay.git
         cd yay
         makepkg -si;;
   n|N ) ;;
   * ) ;;
esac

read -p "Install dependency packages (y/n)? " choice
case "$choice" in
   y|Y ) yay -S --needed --noconfirm $(< deps);;
   n|N ) ;;
   * ) ;;
esac

read -p "Install extra packages (y/n)? " choice
case "$choice" in
   y|Y ) yay -S --needed --noconfirm $(< extra-pkg);;
   n|N ) ;;
   * ) ;;
esac
