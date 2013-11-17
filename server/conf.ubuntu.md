Памятка по настройке Ubuntu.Server 13.*
=======================================

### Для начала
```Shell
sudo aptitude update
```

### zsh
#### Установка
```Shell
sudo aptitude install zsh
sudo chsh -s /bin/zsh root
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
То же самое нужно сделать для остальных пользователей (если нужно).
Изменения встапят в силу после релога.

### git

### dropbox
