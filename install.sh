#!/bin/sh
BASEDIR="$(cd "$( dirname "$0")" && pwd)"
git clone https://github.com/vundlevim/vundle.vim.git $BASEDIR/.vim/bundle/vundle.vi
ln -sf $BASEDIR/.vim ~/.vim
ln -sf $BASEDIR/.vimrc ~/.vimrc
vim +PluginInstall +qall

cd ~/vim/bundle

# tern for vim
cd tern_for_vim
npm install
cd ..

# youcompleteme
cd YouCompleteMe
./install.py --tern-completer 
cd ..
