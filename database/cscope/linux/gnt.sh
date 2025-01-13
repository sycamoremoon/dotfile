#!/bin/sh

DIR=$HOME/linux
if [ ! -d "$DIR" ]; then
	echo "$DIR is not existed!"
	exit 1
fi

cd / && find  $DIR                                                     \
-path "$DIR/arch/*" ! -path "$DIR/arch/riscv*" -prune -o               \
-path "$DIR/tmp*" -prune -o                                           \
-path "$DIR/Documentation*" -prune -o                                 \
-path "$DIR/scripts*" -prune -o                                       \
-path "$DIR/sphinx_latest*" -prune -o                                       \
-path "$DIR/tools*" -prune -o                                       \
    -name "*.[chxsS]" -print >$HOME/.database/cscope/linux/cscope.files
# cscope -Rbqk -i $HOME/.database/cscope/linux/cscope.files
