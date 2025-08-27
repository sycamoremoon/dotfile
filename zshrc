########## EXCUABLE PATH ###########

PATH="${PATH}:$HOME/.local/bin"

PATH="$JAVA_HOME/bin:${PATH}"

PATH="$HOME/.cargo/bin:${PATH}"

######## EXCUABLE PATH END #########

############ VARIABLES #############

export PATH
# Path to Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"
# looking in $ZSH/themes/
export ZSH_THEME="robbyrussell"
export EDITOR='vim'
export TERM=xterm-256color
# ctags file location
export MY_CTAGS_FILE="$HOME/.database/ctags/linux.tags"

########### VARIABLES END ###########

######### SOURCING SETTING ##########

zstyle ':omz:update' mode auto      # update automatically without asking
plugins=(git autojump command-not-found colorize copyfile)
source $ZSH/oh-my-zsh.sh

#Set vim-mode in shell
bindkey -v
set -o vi

#Ignore command history start with space
setopt HIST_IGNORE_SPACE

source <(fzf --zsh)

unsetopt equals

source ~/.sh_alias

# Some local settings which hard to unify
[ -f ~/.zshrc_local ] && source ~/.zshrc_local

####### SOURCING SETTING END #########
if [ -f "$HOME/.mail_alert" ]; then
  echo
  echo -e "\033[1;32m========== MAIL NOTIFICATION ==========\033[0m"
  cat "$HOME/.mail_alert"
  echo -e "\033[1;34mRun 'ack_mail' to dismiss this message.\033[0m"
  echo -e "\033[1;35mRun 'info_mail' to see the detail.\033[0m"
  echo -e "\033[1;32m=======================================\033[0m"
  echo
fi
