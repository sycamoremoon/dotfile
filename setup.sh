#!/bin/sh

FORCE=""
[ "$1" = "-f" ] && FORCE="-f"

# git
ln -s $FORCE $HOME/.dotfile/gitconfig $HOME/.gitconfig

# shell
ln -s $FORCE $HOME/.dotfile/zshrc $HOME/.zshrc
ln -s $FORCE $HOME/.dotfile/sh_alias $HOME/.sh_alias

# tmux
ln -s $FORCE $HOME/.dotfile/tmux.conf $HOME/.tmux.conf

# vim
ln -s $FORCE $HOME/.dotfile/vimrc $HOME/.vimrc
ln -s $FORCE $HOME/.dotfile/vim $HOME/.vim

