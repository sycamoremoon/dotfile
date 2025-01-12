# add-auto-load-safe-path
source ~/.config/gdb/kdump.macro

define nommu
	add-symbol-file dlinux/vmlinux -s .head.text 0x80200000 -s .text 0x80202000 -s .rodata 0x81000000 -s .init.text 0x80c00000 -s .init.data 0x80e00000
end

define trup
	tar ext :1234
end

