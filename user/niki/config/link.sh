#!/bin/sh

BASEDIR=$(dirname $(realpath "$0"))

mkdir -p ~/.config

ln -sn -T $BASEDIR/qutebrowser ~/.config/qutebrowser
ln -sn -T $BASEDIR/kitty ~/.config/kitty
ln -sn -T $BASEDIR/awesome ~/.config/awesome
ln -sn -T $BASEDIR/sxhkd ~/.config/sxhkd
ln -sn -T $BASEDIR/fonts ~/.local/share/fonts
ln -sn -T $BASEDIR/tmux ~/.config/tmux
ln -sn -T $BASEDIR/gitconfig ~/.gitconfig

ln -sn -T $BASEDIR/emacs ~/.config/emacs
ln -sn -T $BASEDIR/emacs/emacs.el ~/.emacs.el

ln -sn -T $BASEDIR/vim/vimrc ~/.vimrc
ln -sn -T $BASEDIR/vim ~/.config/nvim

ln -sn -T $BASEDIR/mpd ~/.config/mpd
ln -sn -T $BASEDIR/ncmpcpp ~/.config/ncmpcpp

ln -sn -T $BASEDIR/bashrc ~/.bashrc
