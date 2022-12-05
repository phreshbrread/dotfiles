#!/bin/bash

sudo pacman -S --needed lightdm-slick-greeter lightdm-settings

sudo sed -i 's/#greeter-session=example-gtk-greeter/greeter-session=lightdm-slick-greeter/g' /etc/lightdm/lightdm.conf
