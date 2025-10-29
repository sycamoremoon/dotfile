########## EXCUABLE PATH ###########

#PATH="${PATH}:$HOME/.local/bin"

######## EXCUABLE PATH END #########

############ VARIABLES #############

export EDITOR='vim'
export TERM=xterm-256color
# ctags file location
export MY_CTAGS_FILE="$HOME/.database/ctags/linux.tags"
#To avoid saving consecutive identical commands, and commands that start with a space
export HISTCONTROL=ignoreboth
export HISTFILESIZE=12000
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

########### VARIABLES END ###########

######### SOURCING SETTING ##########

#Set vim-mode in shell
set -o vi

shopt -s histappend # Avoid history overwrite

source <(fzf --bash)

source ~/.sh_alias

####### SOURCING SETTING END #########
if [ -f "$HOME/.mail_alert" ]; then
  echo
  echo -e "\033[1;32m========== MAIL NOTIFICATION ==========\033[0m"
  echo -e "\033[1;34mRun 'ack_mail' to dismiss this message.\033[0m"
  echo -e "\033[1;35mRun 'info_mail' to see the detail.\033[0m"
  echo -e "\033[1;32m=======================================\033[0m"
  echo
fi

# Some local settings which hard to unify
[ -f ~/.bashrc_local ] && source ~/.bashrc_local
