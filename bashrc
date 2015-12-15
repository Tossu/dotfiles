[[ ! $- == *i* ]] && return

if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

export EDITOR="vim";
export VISUAL="vim";
export HISTSIZE=32768;
export HISTFILESIZE=$HISTSIZE;
export HISTCONTROL=ignoredups;
export HISTIGNORE="ls:cd:cd -:pwd:exit:date:* --help";
export LANG="en_US.UTF-8";
export LC_ALL="en_US.UTF-8";
export LESS_TERMCAP_md="${yellow}";
export MANPAGER="less -X";
export FZF_DEFAULT_COMMAND='ag -l -g ""'
export PATH=$HOME/.cabal/bin:$PATH

pyg() {
    pygmentize -f terminal256 -O style=monokai -g
}

# TODO: one directory
backup() {
    echo "[*] Backing up /documents"
    rsync -a --delete -e ssh /home/$USER/documents/ \
        backup:/home/$USER/documents/;
    echo "[*] Backing up /programming"
    rsync -a --delete -e ssh /home/$USER/programming/ \
        backup:/home/$USER/programming/;
}

sockproxy() {
    if [ -z $1 ]; then
        echo "Usage: sockproxy [username@remotehost]"
    else
        ssh -D 8080 -N $1
    fi;
}

alias ls='ls --color=auto'
alias tree='tree -C'
alias less='less -R'
alias grep='grep --color=auto'
alias g='git'

alias lports='sudo sh -c "lsof -Pan -i tcp -i udp"'
alias fwrules='sudo sh -c "sudo iptables -nvL --line-numbers"'
alias digga='dig any +nocmd +noall +answer +multiline'
alias pjson='python -mjson.tool | less -X | pygmentize -l javascript'
alias wlansetup='nmtui'

# xrandr --output VGA1 --mode 1024x768 --right-of LVDS1
# xrandr --putput VGA1 --off

# alias maildebugserver='python -m smtpd -n -c DebuggingServer localhost:1025'
# alias jyuprinter='ssh username@charra.it.jyu.fi lp -d jysecure-bw <'

alias lsorhpans='sudo pacman -Qdt'
alias rmorphans='sudo pacman -Rs $(pacman -Qtdq)'

PS1=' \W\[\e[0;31m\]]\[\e[0m\] '

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
[ -f ~/.dircolors ] && eval `dircolors ~/.dircolors`
