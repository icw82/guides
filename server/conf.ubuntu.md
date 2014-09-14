Памятка по настройке Ubuntu.Server 14.*
=======================================

### Настройка Wi-Fi с WPA/WPA2
Создать файл с конфигурацией в ```/etc```:
```Shell
sudo wpa_passphrase {name} {password} > /etc/wpa_supplicant.conf
```
где

* ```{name}``` — ESSID, идентификатор беспроводной сети, имя сети;
* ```{password}``` — пароль сети;

В файл ```/etc/network/interfaces``` добавить строки:
```
auto wlan0
iface wlan0 inet dhcp
pre-up sudo wpa_supplicant -B -iwlan0 -c/etc/wpa_supplicant.conf -Dwext
post-down sudo killall -q wpa_supplicant
```

Сохранить и перезагрузиться.

### Для ноутбука
Чтобы система не уходила в спячку при закрытии крышки в файле ```/etc/systemd/logind.conf```
раскомментировать и отредактировать строку:
```
HandleLidSwitch=ignore
```
и перезагрузить или выполнить:
```Shell
sudo restart systemd-logind
```

### Продление сеанса SSH
В конфиг ```/etc/ssh/ssh_config``` добавить строку
```
ServerAliveInterval 180
```

### Обновление пакетов
_(если система была установлена намного раньше)_
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
sudo aptitude install git
```

### dropbox
Актуальная инструкция на сайте [dropbox.com](https://www.dropbox.com/install?os=lnx)
Нужно выйти с рута ```exit``` и выполнять команды из-под пользователя.
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
