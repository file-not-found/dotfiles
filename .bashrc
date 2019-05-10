#
# ~/.bashrc
#

# if not running interactively, don't do anything
[[ $- != *i* ]] && return

# check for tmux
[ -z "$TMUX" ] && { tmux attach || exec tmux new-session && exit;}

# set colors
RED="\[$(tput setaf 1)\]"
GREEN="\[$(tput setaf 2)\]"
BLUE="\[$(tput setaf 4)\]"
CYAN="\[$(tput setaf 6)\]"
RESET="\[$(tput sgr0)\]"

# check for ssh
if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]
then
    HOST="@\h"
else
    HOST=""
fi

# switch color for root
if [[ $EUID -eq 0 ]]
then
    PS1="${RED}\u${HOST}${RESET} ${BLUE}\w${RESET} ${RED}\\$ ${RESET}"
else
    PS1="${GREEN}\u${HOST}${RESET} ${BLUE}\w${RESET} ${GREEN}\\$ ${RESET}"
fi

# environment
export EDITOR=vim

# aliases
alias ls='ls --color=auto'
alias copy='xclip -sel clip'
alias ff='find -type f -ls'
alias ft='find -type f -exec file {} \;'
alias fpe='find -type f -exec file {} \; | grep -P "PE32\+? executable"'
