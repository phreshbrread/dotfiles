#! /bin/bash

wd=$(pwd)

cd ~/dotfiles
git add --all
git commit --message='Add files via upload'
git push

cd $wd
