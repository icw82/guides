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
```Shell
aptitude install git
```

### dropbox
Актуальная инструкция на сайте [dropbox.com](https://www.dropbox.com/install?os=lnx)
Нужно выйти с рута ```exit``` и пыполнять команды из-под пользователя.
```Shell
cd ~ && wget -O - "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf -
~/.dropbox-dist/dropboxd
```
Скопировать ссылку и запустить её в браузере, чтобы привязать аккаунт.
Далее:
```Shell
wget -O ~/dropbox.py "http://www.dropbox.com/download?dl=packages/dropbox.py"
chmod 755 ~/dropbox.py
sudo ln -s ~/dropbox.py /usr/local/bin/dropbox
dropbox start
```
