########## EXCUABLE PATH ###########

# Setting PATH for Python
PATH="$HOME/.local/venv/bin:${PATH}"

PATH="${PATH}:$HOME/.local/bin"

######## EXCUABLE PATH END #########

############ VARIABLES #############

export PATH
# Path to Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"
# looking in $ZSH/themes/
export ZSH_THEME="robbyrussell"
# Setting PATH for Python venv
export PYTHONPATH="/home/damon/.local/venv/lib/python3.12/site-packages"
export EDITOR='vim'
export TERM=xterm-256color

########### VARIABLES END ###########

######### SOURCING SETTING ##########

zstyle ':omz:update' mode auto      # update automatically without asking
plugins=(git autojump command-not-found colorize copyfile)
source $ZSH/oh-my-zsh.sh

#Set vim-mode in shell
bindkey -v

#Ignore command history start with space
setopt HIST_IGNORE_SPACE

source <(fzf --zsh)

unsetopt equals

source ~/.sh_alias

# Some local settings which hard to unify
[ -f ~/.zshrc_local ] && source ~/.zshrc_local

####### SOURCING SETTING END #########


