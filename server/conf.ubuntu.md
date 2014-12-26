Памятка по настройке Ubuntu.Server 14
=======================================

### Права доступа и группы
```Shell
sudo groupadd admin
sudo gpasswd -a {USERNAME} admin
sudo visudo
```
* `%sudo` закоментировать;
* `%admin ALL=(ALL) NOPASSWD: ALL`;
* Релог.


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

### Обновление пакетов
```Shell
sudo aptitude update
```

### emacs
```Shell
sudo aptitude install emacs24-nox
```

### SSH
Сгенерить ключи в PuTTYgen (если под виндой).

```Shell
mkdir ~/.ssh
chmod 700 ~/.ssh
emacs ~/.ssh/authorized_keys2 (вставить сюда публичный ключ)
chmod 600 ~/.ssh/authorized_keys2
```
<!--
### Продление сеанса SSH (server)
В конфиг ```/etc/ssh/sshd_config``` добавить строки:
```
ClientAliveInterval 30
ClientAliveCountMax 99999
```
Перезапустить сервер:
```
sudo /etc/init.d/sshd restart
```
-->

### zsh

```Shell
sudo aptitude install zsh
sudo chsh -s /bin/zsh root
chsh -s /bin/zsh
exit
```
После логина будет автоматически запущен __zsh-newuser-install__.
Нажать `0` (просто создастся файл .zshrc в домашней директории).

Открыть файл .zshrc в домашней директории:
```Shell
emacs ~/.zshrc
```
Вставить в этот файл [сие](../storeroom/.zshrc.sh).
То же самое нужно сделать для остальных пользователей (если нужно).
Изменения встапят в силу после релога.

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

### —
```Shell
sudo aptitude install htop
sudo aptitude install mc
```
Занятое пространство накопителя `df -h`.

`nginx_dissite + nginx_ensite`
