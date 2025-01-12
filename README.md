# dotfile
Very frustrating to switch working environments back and forth

**Nothing Special**, just a little scripts/macros but very handy and light-weight.

## tips

```
linux> cd ~ && mkdir .dotfile && cd .dotfile
linux> git clone https://github.com/sycamoremoon/dotfile.git .
```
Better chose the `blank` branch, if you want to setup by yourself. Never mind to take a look of my ugly dotfiles.

`sh_alias` and `setup.sh` are the core, especially `sh_alias`. Source it and get two macros: **dotlink** and **dotdiff**:

```
linux> cd ~
linux> source .dotfile/sh_alias
```

- `dotlink` is used for moving your personal dotfile to `.dotfile` directory.

```
# For example to keep ".zshrc"
linux> dotlink .zshrc
Moved .zshrc to /home/hack/.dotfile/zshrc
lrwxrwxrwx 1 hack hack 25 Jan 13 01:59 /home/hack/.zshrc -> /home/hack/.dotfile/zshrc

# Another example to keep ".config/mutt/muttrc"
linux> dotlink .config/mutt/muttrc
Moved .config/mutt/muttrc to /home/hack/.dotfile/config/mutt/muttrc
lrwxrwxrwx 1 hack hack 38 Jan 13 02:01 /home/hack/.config/mutt/muttrc -> /home/hack/.dotfile/config/mutt/muttrc
```

- `dotdiff` is used for see conflicts when porting from machine A to B

```
# For example `dotlink .zshrc` failed
linux> dotdiff .zshrc
```
- Once you finished, record your settings to `setup.sh` for future using such as `dotsetup zshrc`,`dotsetup config/mutt/muttrc`. See `linux` branch's `setup.sh` for more examples.

```
# Next time just run script on other machines
linux> ./.dotfile/setup.sh
# if you are sure to overwrite the old dotfile
linux> ./.dotfile/setup.sh -f 
```
## Have Fun!
