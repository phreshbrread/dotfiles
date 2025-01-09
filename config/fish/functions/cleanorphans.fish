function cleanorphans
pacman -Qtdq | sudo pacman -Rns -
end
