#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Allow autocompletion for sudo/man prefixe
if [ "$PS1" ]; then
	complete -cf sudo
	complete -cf man
fi

if [ -f /etc/bash_completion ]; then
	/etc/bash_completion
fi

# Coloring
# Enable coloring for Termite
eval $(dircolors ~/.dircolors)
# Set of colors for man pages
man() {
    env LESS_TERMCAP_mb=$'\E[01;31m' \
    LESS_TERMCAP_md=$'\E[01;38;5;74m' \
    LESS_TERMCAP_me=$'\E[0m' \
    LESS_TERMCAP_se=$'\E[0m' \
    LESS_TERMCAP_so=$'\E[38;5;246m' \
    LESS_TERMCAP_ue=$'\E[0m' \
    LESS_TERMCAP_us=$'\E[04;38;5;146m' \
    man "$@"
}

# Set of colors for less
export LESS=-R
export LESS_TERMCAP_me=$(printf '\e[0m')
export LESS_TERMCAP_se=$(printf '\e[0m')
export LESS_TERMCAP_ue=$(printf '\e[0m')
export LESS_TERMCAP_mb=$(printf '\e[1;32m')
export LESS_TERMCAP_md=$(printf '\e[1;34m')
export LESS_TERMCAP_us=$(printf '\e[1;32m')
export LESS_TERMCAP_so=$(printf '\e[1;44;1m')

# Exports
# Default editor
export VISUAL=vim

# Aliases
alias ls='ls --color=auto'
alias ll='ls -al --color=auto'
alias pingc='ping 8.8.8.8 -c 10'

# Default folder for wget
alias wget='wget --directory-prefix=/home/brick/Téléchargements'

PS1='\[$(tput bold)\][\[$(tput sgr0)\]\[$(tput sgr0)\]\[\033[38;5;6m\]\u\[$(tput bold)\]\[$(tput sgr0)\]\[\033[38;5;15m\]@\[$(tput sgr0)\]\[$(tput sgr0)\]\[\033[38;5;6m\]\h\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]\[\033[38;5;202m\]\W\[$(tput bold)\]\[$(tput bold)\]\[\033[38;5;15m\]]\[$(tput sgr0)\]\\$ \[$(tput sgr0)\]'
