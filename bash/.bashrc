#
# ~/.bashrc
# 
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Load up RVM if available
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# RVM bash completion
[[ -r "$HOME/.rvm/scripts/completion" ]] && source "$HOME/.rvm/scripts/completion"

# Load up NVM if available
[[ -s "/usr/share/nvm" ]] && source "/usr/share/nvm/init-nvm.sh"

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

# Enabling cd when only a path is entered
shopt -s autocd

# Exports
# Default editor
export VISUAL=vim
# Default browser
export BROWSER=chromium
# Color fix for lightline.vim plugin
export TERM=xterm-256color
# Allows FZF to index dotfiles
export FZF_DEFAULT_COMMAND='find .'
# Add RVM to PATH for scripting
export PATH="$PATH:$HOME/.rvm/bin"

# Aliases
alias dgnetctl='NETCTL_DEBUG=yes netctl' # Enabling debug with netctl
alias grep='grep -i' # line number option
alias ll='ls -al --color=auto'
alias ls='ls --color=auto'
alias lt='ls -lt'
alias minecraft-server='cd ~/minecraft && java -jar -Xmn4G btw_server.jar --nogui'
alias minecraft='java -jar ~/Minecraft.jar > /dev/null &'
alias pingc='ping 8.8.8.8 -c 10'
alias rf='rm -rfI'
alias stow='stow -d ~/dotfiles' # default file for stow
alias wget='wget --directory-prefix=/home/brick/Téléchargements' # Default folder for wget

# PS1
PS1='\[$(tput bold)\][\[$(tput sgr0)\]\[$(tput sgr0)\]\[\033[38;5;6m\]\u\[$(tput bold)\]\[$(tput sgr0)\]\[\033[38;5;15m\]@\[$(tput sgr0)\]\[$(tput sgr0)\]\[\033[38;5;6m\]\h\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]\[\033[38;5;202m\]\W\[$(tput bold)\]\[$(tput bold)\]\[\033[38;5;15m\]]\[$(tput sgr0)\]\\$ \[$(tput sgr0)\]'
