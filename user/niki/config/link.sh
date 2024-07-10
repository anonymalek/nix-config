#!/bin/sh

BASEDIR=$(dirname $(realpath "$0"))

ln -sin -T $BASEDIR/qutebrowser ~/.config/qutebrowser
ln -sin -T $BASEDIR/kitty ~/.config/kitty
ln -sin -T $BASEDIR/awesome ~/.config/awesome
ln -sin -T $BASEDIR/sxhkd ~/.config/sxhkd
ln -sin -T $BASEDIR/fonts ~/.local/share/fonts
ln -sin -T $BASEDIR/tmux ~/.config/tmux
ln -sin -T $BASEDIR/gitconfig ~/.gitconfig

ln -sin -T $BASEDIR/emacs/emacs.el ~/.emacs
ln -sin -T $BASEDIR/emacs/emacs.d ~/.emacs.d

ln -sin -T $BASEDIR/vim/vimrc ~/.vimrc
ln -sin -T $BASEDIR/vim ~/.config/nvim

ln -sin -T $BASEDIR/mpd ~/.config/mpd
ln -sin -T $BASEDIR/ncmpcpp ~/.config/ncmpcpp

ln -sin -T $BASEDIR/bashrc ~/.bashrc
