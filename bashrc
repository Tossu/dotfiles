[[ ! $- == *i* ]] && return

PS1=' \W\[\e[0;31m\]]\[\e[0m\] '

export LANG="en_US.UTF-8";
export LC_ALL="en_US.UTF-8";
export EDITOR="vi";
export VISUAL="vi";
export MANPAGER="less -X";

alias g='git'
alias gb='git branch'
alias gs='git status'
alias gd='git diff'
alias gc='git checkout'

alias ls='ls --color=auto'
alias tree='tree -C'
alias less='less -R'
alias grep='grep --color=auto'

[ -f ~/.dircolors ] && eval `dircolors ~/.dircolors`
