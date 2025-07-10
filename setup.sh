#!/bin/sh

FORCE=""
[ "$1" = "-f" ] && FORCE="-f"

dotsetup() {
	local file="$1"
	local actual_file="$HOME/.dotfile/$file"
	local linked_file="$HOME/.$file"

	if [ ! -e "$actual_file" ]; then
		echo "$actual_file is not existed!"
		exit 1
	fi

	if [ -e "$linked_file" ]; then
		diff "$actual_file" "$linked_file"
		if [[ "$?" != 0 ]]; then
			ln -s $FORCE $actual_file $linked_file
			if [[ "$?" != 0 ]]; then
				echo "Failed, stopped in $linked_file."
				exit 1
			else
				if [[ "$FORCE" == "-f" ]]; then
					echo "$linked_file forcely updated."
					exit 0
				fi
			fi
		fi
	else
		echo "$linked_file no exist, about to create new"
		local directory=$(dirname "$linked_file")
		if [ ! -e "$directory" ]; then
			echo "$directory no such a directory!"
			exit 1
		fi
		ln -s $FORCE $actual_file $linked_file
	fi
}

# git
# dotsetup gitconfig

# shell
dotsetup zshrc
dotsetup sh_alias

# tmux
dotsetup tmux.conf

# vim
dotsetup vimrc
# dotsetup vim ##backup the whole directory is deprecated##
dotsetup vim/autoload/lightline/colorstheme/dark.vim
dotsetup vim/autoload/plug.vim
dotsetup vim/colors/solarized.vim

# ssh
dotsetup ssh/config

# mail
dotsetup config/isyncrc
dotsetup config/mailcap
dotsetup config/mutt/muttrc
dotsetup config/mutt/neomuttrc
dotsetup config/mutt/gmail.rc
dotsetup config/mutt/syca.rc
dotsetup config/mutt/outlook.rc
dotsetup config/mutt/syca.rc
dotsetup config/mutt/mutt_oauth2.py
dotsetup config/mutt/colors.rc
dotsetup config/msmtp/config

# gdb
dotsetup gdbinit
dotsetup config/gdb/kdump.macro

# database
dotsetup database

# X
# dotsetup xinitrc
# dotsetup Xmodmap
# dotsetup config/i3/config

# local scripts
dotsetup local/bin/gbk2utf8
