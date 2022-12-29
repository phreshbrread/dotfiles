function backupdotfiles
cd ~/dotfiles

rm -rf config
rm -rf rofi-themes

mkdir config
mkdir rofi-themes

cd config
cp -r ~/.config/i3 .
cp -r ~/.config/fish .
cp -r ~/.config/polybar .
cp -r ~/.config/awesome .
cp -r ~/.config/neofetch .
cp -r ~/.config/alacritty .

cd ../

cp ~/.local/share/rofi/themes/* rofi-themes

#cp ~/.profile .
cp ~/.xprofile .
cp ~/.nanorc .
end
