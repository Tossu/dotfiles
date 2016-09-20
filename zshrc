autoload -U colors && colors

PROMPT=" %1~%{$fg[red]%}] %{$reset_color%}"

# GIT status
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
zstyle ':vcs_info:*' formats '%b'
RPROMPT=\$vcs_info_msg_0_

alias ls='ls --color=auto'
alias tree='tree -C'
alias less='less -R'
alias grep='grep --color=auto'
alias c='cat'

alias g='git'
alias gb='git branch'
alias gs='git status'
alias gd='git diff'
alias gc='git checkout'

alias r='rails'
alias p='python'
alias pm='python manage.py'
alias vim='nvim'
alias v='nvim'

alias work_monitor_off='xrandr --output HDMI1 --off'

alias remove_branches='git branch --merged develop --no-color | grep -v master | grep -v develop | xargs git branch -d'

# Use completion system
autoload -Uz compinit && compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2 eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*' force-list always

# ZPLUG
source "${HOME}/.zplug/zplug"

zplug "zsh-users/zsh-syntax-highlighting"

# zplug check return true if all plugins are installed
# Therefore, when it returns not true (thus false),
# run zplug install
if ! zplug check; then
    zplug install
fi

# Then, source plugins and add commands to $PATH
zplug load

export DJANGO_SETTINGS_MODULE=settings.development

function magnet_to_torrent() {
    [[ "$1" =~ xt=urn:btih:([^\&/]+) ]] || return 1

    hashh=${match[1]}

    if [[ "$1" =~ dn=([^\&/]+) ]];then
        filename=${match[1]}
    else
        filename=$hashh
    fi

    echo "d10:magnet-uri${#1}:${1}e" > "$filename.torrent"
}

function monni() {
    if [ $(xrandr | grep "HDMI1 connected" -c) -gt 0 ]; then
        xrandr --output HDMI1 --auto --right-of eDP1 &
    else
        xrandr --output HDMI1 --off
    fi
}

export PYTHONSTARTUP=~/.startup.py
export ANDROID_HOME=~/android-sdk
export PATH="$HOME/bin:$PATH"

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
source "$HOME/.rvm/scripts/rvm"
