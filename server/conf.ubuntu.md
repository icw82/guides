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
Вставить в этот файл [сие](https://raw.github.com/icw82/storeroom/master/zsh/.zshrc.sh).


### git

### dropbox
