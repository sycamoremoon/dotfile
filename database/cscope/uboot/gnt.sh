#!/bin/sh

DIR=$HOME/uboot
if [ ! -d "$DIR" ]; then
	echo "$DIR is not existed!"
	exit 1
fi

cd / && find  $DIR                                                     \
-path "$DIR/arch/*" ! -path "$DIR/arch/riscv*" -prune -o               \
-path "$DIR/tmp*" -prune -o                                           \
-path "$DIR/Documentation*" -prune -o                                 \
-path "$DIR/scripts*" -prune -o                                       \
-path "$DIR/sphinx_latest*" -prune -o                                 \
-path "$DIR/tools*" -prune -o                                       \
-path "$DIR/test*" -prune -o                                       \
-path "$DIR/example*" -prune -o                                       \
    -name "*.[chxsS]" -print >$HOME/.database/cscope/uboot/cscope.files

if [[ "$1" != "-S" ]]; then
	cscope -Rbqk \
		-i $HOME/.database/cscope/uboot/cscope.files \
		-f $HOME/.database/cscope/uboot/cscope.out
fi

ls -lh $HOME/.database/cscope/uboot
