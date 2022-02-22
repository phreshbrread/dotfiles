function pushdotfiles
cd ~/dotfiles
git add --all
git commit --message='Update configs'
git push
end
