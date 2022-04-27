function backupdotfiles
cd ~/dotfiles/

rm -rf .config

mkdir .config
cd .config

cp -r ~/.config/i3 (pwd)
cp -r ~/.config/fish (pwd)
cp -r ~/.config/picom (pwd)
cp -r ~/.config/polybar (pwd)
cp -r ~/.config/alacritty (pwd)

mkdir -p ~/dotfiles/.local/share/rofi/themes/
cp ~/.local/share/rofi/themes/nord.rasi ~/dotfiles/.local/share/rofi/themes

cd ~/dotfiles
end
