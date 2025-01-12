#!/bin/sh

FORCE=""
[ "$1" = "-f" ] && FORCE="-f"

dotsetup() {
	local file="$1"
	local actual_file="$HOME/.dotfile/$file"
	local linked_file="$HOME/.$file"

	if [ ! -f "$actual_file" ]; then
		echo "$actual_file is not existed!"
		return 1
	fi

	if [ -f "$linked_file" ]; then
		diff "$actual_file" "$linked_file"
		if [[ "$?" != 0 ]]; then
			ln -s $FORCE $actual_file $linked_file
		fi
		if [[ "$?" != 0 ]]; then
			echo "Stopped in linking $linked_file"
			exit 1
		fi
	else
		ln -s $FORCE $actual_file $linked_file
	fi
}

# git
dotsetup gitconfig

# shell
dotsetup zshrc
# dotsetup sh_alias

# tmux
# dotsetup tmux.conf

# vim
# dotsetup vimrc
# dotsetup vim

