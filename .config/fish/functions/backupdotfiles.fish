function backupdotfiles
cd ~/dotfiles

rm -rf .config
rm -rf rofi-themes
rm -rf wallpapers

mkdir .config
mkdir rofi-themes
mkdir wallpapers

cd .config
cp -r ~/.config/i3 .
cp -r ~/.config/fish .
cp -r ~/.config/picom .
cp -r ~/.config/polybar .
cp -r ~/.config/neofetch .
cp -r ~/.config/alacritty .

cd ../

cp -r ~/Pictures/Wallpapers wallpapers

cp ~/.local/share/rofi/themes/* rofi-themes
end
