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


alias kauppalehti='python ~/scripts/kauppalehti.py'
alias sale='python ~/scripts/sale.py'
alias cal='python ~/scripts/cal.py'

alias nr='npm run'
alias lp='ls --color=auto --hide="*.pyc"'
alias ls='ls --color=auto'
alias digga='dig any +nocmd +noall +answer +multiline'
alias pjson='python -mjson.tool | less -X'
alias wlansetup='nmtui'
alias wlanhome='nmtui-connect Home'
alias ports='su -c "lsof -Pan -i tcp -i udp"'
alias maildebugserver='python -m smtpd -n -c DebuggingServer localhost:1025'

PS1='[\u@\h \W]\$ '
