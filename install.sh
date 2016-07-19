#!/bin/sh
BASEDIR="$(cd "$( dirname "$0")" && pwd)"
git clone https://github.com/vundlevim/vundle.vim.git $BASEDIR/.vim/bundle/vundle.vi
ln -sf $BASEDIR/.vim ~/.vim
ln -sf $BASEDIR/.vimrc ~/.vimrc
