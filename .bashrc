#
# ~/.bashrc
#

# if not running interactively, don't do anything
[[ $- != *i* ]] && return

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

    # # check for tmux
    # [ -z "$TMUX" ] && { tmux attach || exec tmux new-session && exit;}
fi

# switch color for root
if [[ $EUID -eq 0 ]]
then
    PS1="${RED}\u${HOST}${RESET} ${CYAN}\w${RESET} ${RED}\\$ ${RESET}"
else
    PS1="${GREEN}\u${HOST}${RESET} ${CYAN}\w${RESET} ${GREEN}\\$ ${RESET}"
fi

FZF_DIRS=("$HOME" "/etc")
if [ -d "/media" ]
then
    FZF_DIRS+=("/media")
fi
if [ -d "/run/media" ]
then
    FZF_DIRS+=("/run/media")
fi

# fuzzy finder
if [ -x "$(command -v fzf)"  ]
then
    source $(find $(find /usr/share -type d -name fzf) -type f -name key-bindings.bash)
    # # unfuzzy search
    # FZF_DEFAULT_OPTS="-e $FZF_DEFAULT_OPTS"
    if [ -x "$(command -v fd)"  ]
    then
        FZF_CTRL_T_COMMAND='fd -H . $FZF_DIRS'
    fi
    if [ -x "$(command -v fdfind)"  ]
    then
        FZF_CTRL_T_COMMAND='fdfind -H . $FZF_DIRS'
    fi
fi

# environment
export EDITOR=vim
export PATH="$HOME/.local/bin:$PATH"

# bash completion
bind TAB:menu-complete
bind "set show-all-if-ambiguous on"
bind "set menu-complete-display-prefix on"

# aliases
alias ls='ls --color=auto'
alias ll='ls -la --color=auto'
alias ff='find -type f -ls'
alias ft='find -type f -exec file {} \;'
alias fpe='find -type f -exec file {} \; | grep -P "PE32\+? executable"'
alias tmp='cd `mktemp -d`'
alias pw='openssl rand 400 | tr -dc '\''A-Z0-9'\'' | sed '\''s/.\{4\}/&-/g'\'' | head -c 24; echo'
alias clip='xclip -selection clipboard'
