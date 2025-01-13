#!/bin/sh

DIR=$1
TAR=$(basename $DIR)

if [ ! -d "$DIR" ]; then
	echo "$DIR no such a directory!"
	exit 1
fi

ctags -f "$HOME/.database/ctags/$TAR.tags" -R "$DIR"
ls -lh "$HOME/.database/ctags/$TAR.tags"
