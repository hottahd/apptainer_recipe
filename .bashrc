# .bashrc


# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# PATH for conda
export CDPATH=$CDPATH:..
export XDG_RUNTIME_DIR=/home/u10094/runtime-u10094

#Aliases
alias rm='rm -i'
alias ls='ls -vF'

# autocd option
shopt -s autocd

# Erase duplicate command in hisotry
HISTCONTROL=erasedups
# Number of command history
HISTSIZE=5000000
HISTFILESIZE=5000000

export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"
shopt -u histappend
