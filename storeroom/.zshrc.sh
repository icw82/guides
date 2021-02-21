# icw82's .zshrc

export TERM=xterm-256color

autoload -U compinit; compinit
#autoload colors; colors

setopt AUTO_CD
#setopt BRACECCL


# История
HISTFILE=~/.zhistory
SAVEHIST=8200
HISTSIZE=8200

setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt HIST_NO_STORE


# Синонимы
alias ls='ls -F --color=auto'
alias ll='ls -lah'
alias lsd='ls -ldh *(-/DN)'
alias lsa='ls -ld .*'

alias ggg='git add --all | git commit -m "auto update" | git push'
alias gs='git status'

alias grep='grep -E --color=auto'
alias df='df -h'
alias gp='git pull'


# ФОРМАТ
reset=$'%{\e[m%}'
gray=$'%{\e[38;05;240m%}'
blue=$'%{\e[1;38;5;33m%}'
green=$'%{\e[01;38;05;71m%}'
orange=$'%{\e[01;38;05;214m%}'

if [ "$EUID" -eq 0 ]; then
    PROMPT="${gray}[${orange}%d${gray}] #${reset} "
else
    if [ "$EUID" -eq 82 ]; then
        PROMPT="${gray}%n [${green}%d${gray}] \$${reset} "
    else
        PROMPT="${gray}%n [${blue}%d${gray}] \$${reset} "
    fi
fi

RPROMPT="${gray}%*${reset}"

if [ -f /usr/bin/grc ]; then
 alias gcc="grc --colour=auto gcc"
 alias irclog="grc --colour=auto irclog"
 alias log="grc --colour=auto log"
 alias netstat="grc --colour=auto netstat"
 alias ping="grc --colour=auto ping"
 alias proftpd="grc --colour=auto proftpd"
 alias traceroute="grc --colour=auto traceroute"
fi

# Bindings

## Words
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word

# Keypad
# 0 . Enter
bindkey -s "^[Op" "0"
bindkey -s "^[Ol" "."
bindkey -s "^[OM" "^M"
# 1 2 3
bindkey -s "^[Oq" "1"
bindkey -s "^[Or" "2"
bindkey -s "^[Os" "3"
# 4 5 6
bindkey -s "^[Ot" "4"
bindkey -s "^[Ou" "5"
bindkey -s "^[Ov" "6"
# 7 8 9
bindkey -s "^[Ow" "7"
bindkey -s "^[Ox" "8"
bindkey -s "^[Oy" "9"
# + -  * /
bindkey -s "^[Ok" "+"
bindkey -s "^[Om" "-"
bindkey -s "^[Oj" "*"
bindkey -s "^[Oo" "/"
