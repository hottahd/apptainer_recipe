# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

#Aliases
alias rm='rm -i'
alias ls='ls -vF'
#alias log='tail -f log.txt'

# autocd option
shopt -s autocd

# Erase duplicate command in hisotry
HISTCONTROL=erasedups
# Number of command history
HISTSIZE=5000000
HISTFILESIZE=5000000

export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"
shopt -u histappend