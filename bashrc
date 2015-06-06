[[ ! $- == *i* ]] && return

if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

export EDITOR="vim";
export HISTSIZE=32768;
export HISTFILESIZE=$HISTSIZE;
export HISTCONTROL=ignoredups;
export HISTIGNORE="ls:cd:cd -:pwd:exit:date:* --help";
export LANG="en_US.UTF-8";
export LC_ALL="en_US.UTF-8";
export LESS_TERMCAP_md="${yellow}";
export MANPAGER="less -X";
export FZF_DEFAULT_COMMAND='ag -l -g ""'

# make those use sudo instead su
alias ports='su -c "lsof -Pan -i tcp -i udp"'
openport() {
    PORT=$1
    su root -c "echo Opening port: $PORT;\
        iptables -A INPUT -p tcp --dport $PORT -j ACCEPT;\
        iptables -nL | grep $PORT"
}
closeport() {
    PORT=$1
    su root -c "echo Closing port: $PORT;\
        iptables -D INPUT -p tcp --dport $PORT -j ACCEPT;\
        iptables -nL | grep $PORT"
}

# FZF magic

fmount() {
    local device
    device=$(gvfs-mount -li | awk '/'unix-device:'/ {print $2}' | fzf) &&
    gvfs-mount -d ${device//\'}
}

fumount() {
    local path
    path=$(gvfs-mount -li | awk '/'\-\>'/ {print $4}' | uniq | fzf) &&
    gvfs-mount -u $path
}

ff() {
    ag --nobreak --nonumbers --noheading . | fzf
}

fd() {
    local dir
    dir=$(find ${1:-*} -path '*/\.*' -prune \
        -o -type d -print 2> /dev/null | fzf +m) &&
    cd "$dir"
}

fkill() {
    pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')

    if [ "x$pid" != "x" ]; then
        kill -${1:-9} $pid
    fi
}

fo() {
    local out file key
    out=$(fzf-tmux --query="$1" --exit-0 --expect=ctrl-o,ctrl-e)
    key=$(head -1 <<< "$out")
    file=$(head -2 <<< "$out" | tail -1)
    if [ -n "$file" ]; then
        [ "$key" = ctrl-o ] && xdg-open "$file" || ${EDITOR:-vim} "$file"
    fi
}

alias kauppalehti='python ~/scripts/kauppalehti.py'
alias sale='python ~/scripts/sale.py'
alias cal='python ~/scripts/cal.py'

alias ls='ls --color=auto'
alias digga='dig any +nocmd +noall +answer +multiline'
alias pjson='python -mjson.tool | less -X'
alias wlansetup='nmtui'
alias wlanhome='nmtui-connect Home'
alias maildebugserver='python -m smtpd -n -c DebuggingServer localhost:1025'

PS1=' \W\[\e[0;31m\]]\[\e[0m\] '

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
