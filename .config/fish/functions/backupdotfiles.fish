function backupdotfiles
cd ~/dotfiles/

rm -rf .config
rm -rf rofi-themes
rm -rf wallpapers 

mkdir .config
mkdir ~/dotfiles/rofi-themes

cp -r ~/.config/i3 .config
cp -r ~/.config/fish .config
cp -r ~/.config/picom .config
cp -r ~/.config/polybar .config
cp -r ~/.config/alacritty .config

cp -r ~/Pictures/Wallpapers wallpapers

cp ~/.local/share/rofi/themes/* rofi-themes

cd ~/dotfiles
end
