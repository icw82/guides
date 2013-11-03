Памятка по настройке Ubuntu.Server 13.*
=======================================

### zsh
#### Установка
```Shell
sudo aptitude install zsh
chsh -s /bin/zsh
exit
```
После логина будет автоматически запущен __zsh-newuser-install__.
Нажать `0` (просто создастся файл .zshrc в домашней директории).

#### Конфигурация
Открыть файл .zshrc в домашней директории:
```Shell
nano ~/.zshrc
```
Вставить в файл следующее
```Shell
# icw82
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
#setopt HIST_EXPIRE_DUPS_FIRST
#setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt HIST_NO_STORE


# Синонимы
alias ls='ls -F --color=auto'
alias l=ls
alias ll='ls -l'
alias lll='ls -la'

alias li='ls -ial'
alias lsd='ls -ld *(-/DN)'
alias lsa='ls -ld .*'

alias grep='grep --color=auto'


# Цвета
reset=$'%{\e[m%}'
blue=$'%{\e[01;38;05;146m%}'
gray=$'%{\e[38;05;238m%}'
green=$'%{\e[01;38;05;71m%}'
orange=$'%{\e[01;38;05;214m%}'


if [ "$EUID" -eq 0 ]; then
  PROMPT="${host}${gray}[${orange}%d${gray}]${reset} \# "
else
  PROMPT="${host}${gray}[${green}%d${gray}]${reset} \$ "
fi

RPROMPT="${blue}%*${reset}"
```

### git

### dropbox