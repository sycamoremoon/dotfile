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
		fi
		if [[ "$?" != 0 ]]; then
			echo "Stopped in linking $linked_file"
			exit 1
		fi
	else
		echo "$linked_file no exist, create new"
		ln -s $FORCE $actual_file $linked_file
	fi
}

setupmailbox() {
	local account=$1
	local force=$2
	ln -s$force $HOME/.local/share/mail/$account/{\[Gmail\]/Drafts,Drafts}
	ln -s$force $HOME/.local/share/mail/$account/{\[Gmail\]/Spam,Junk}
	ln -s$force $HOME/.local/share/mail/$account/{\[Gmail\]/Sent\ Mail,Sent}
	ln -s$force $HOME/.local/share/mail/$account/{\[Gmail\]/Trash,Trash}
}

# git
dotsetup gitconfig

# shell
dotsetup zshrc
dotsetup sh_alias

# tmux
dotsetup tmux.conf

# vim
dotsetup vimrc
dotsetup vim

# ssh
dotsetup ssh/config

# mail
# setupmailbox sycamoremoon376@gmail.com
dotsetup config/mutt/accounts/sycamoremoon376@gmail.com.muttrc
dotsetup local/share/mutt-wizard/mutt-wizard.muttrc
dotsetup config/msmtp/config
