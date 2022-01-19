# Памятка по настройке Ubuntu.Server

Ubuntu 20.04

## Права доступа и группы

```sh
sudo groupadd admin
sudo adduser {USERNAME}
sudo usermod -aG sudo {USERNAME}
sudo gpasswd -a {USERNAME} admin
sudo visudo

sudo passwd {USERNAME}
```

### Если нет авторизации по ключам

```sh
(umask 077 && test -d ~/.ssh || mkdir ~/.ssh)
(umask 077 && touch ~/.ssh/authorized_keys)

nano ~/.ssh/authorized_keys
или
ssh-import-id-gh {USERNAME on GIT}
```

```sh
sudo nano /etc/ssh/sshd_config
```

https://www.digitalocean.com/community/tutorials/ssh-ubuntu-18-04-ru

```text
PermitRootLogin no
PasswordAuthentication no

PubkeyAuthentication yes

AllowUsers {USERNAME}
```

Перезапустить

```sh
sudo service ssh --full-restart
```

Авторизоваться с помощью ключа.

## Обновление пакетов

```Shell
sudo apt update && sudo apt upgrade -y
sudo apt install language-pack-ru -y
```

## Установка пакетов

Базовое

```Shell
sudo apt install software-properties-common
sudo add-apt-repository ppa:deadsnakes/ppa
sudo apt install -y python3.9 python3-pip python3.9-venv
```

```Shell
sudo apt install -y snapd emacs-nox zsh htop ncdu neofetch \
    tmux mc nmap ranger nnn git fail2ban

sudo snap install core; sudo snap refresh core
```

<!-- tig sysstat fail2ban -->

<!-- lm-sensors -->

<!-- btop musikcube googler rainbowstream (Twitter) wttr ncspot nnn mapscii -->

Для разработки

```Shell
sudo apt-get install -y emacs-nox zsh htop tmux mc ncdu nmap ranger neofetch \
    lm-sensors tig sysstat git fail2ban
```

<!--
## SSH

Сгенерить ключи в PuTTYgen (если под виндой).

```Shell
mkdir ~/.ssh
chmod 700 ~/.ssh
emacs ~/.ssh/authorized_keys2 (вставить сюда публичный ключ)
chmod 600 ~/.ssh/authorized_keys2
```

## Продление сеанса SSH (server)
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

## zsh

```Shell
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

## dropbox

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

Занятое пространство накопителя `df -h`.

`nginx_dissite + nginx_ensite`

## Nginx

```Shell
sudo snap install --classic certbot
sudo ln -s /snap/bin/certbot /usr/bin/certbot

sudo apt-get install nginx
sudo /etc/init.d/nginx start
emacs /etc/nginx/nginx.conf

sudo certbot --nginx
```

[nginx.conf](../storeroom/nginx.conf)

## Python + pip + virtualenv + uwsgi

```Shell
sudo aptitude install build-essential python-dev
wget https://bootstrap.pypa.io/ez_setup.py -O - | sudo python
sudo easy_install pip
sudo pip install virtualenv
sudo pip install uwsgi
```

## git

```Shell
sudo aptitude install git
```

## Node.js

```Shell
sudo aptitude install nodejs
sudo aptitude install npm
```

## Рабочие каталоги

```
sudo mkdir /var/www
sudo chown www-data:www-data /var/www/
```

--------------------------------------------------------------------------------

## Настройка Wi-Fi с WPA/WPA2

Создать файл с конфигурацией в ```/etc```:

```Shell
sudo wpa_passphrase {name} {password} > /etc/wpa_supplicant.conf
```

где

* ```{name}``` — ESSID, идентификатор беспроводной сети, имя сети;
* ```{password}``` — пароль сети;

В файл ```/etc/network/interfaces``` добавить строки:

```Shell
auto wlan0
iface wlan0 inet dhcp
pre-up sudo wpa_supplicant -B -iwlan0 -c/etc/wpa_supplicant.conf -Dwext
post-down sudo killall -q wpa_supplicant
```

Сохранить и перезагрузиться.

## Для ноутбука

Чтобы система не уходила в спячку при закрытии крышки в файле ```/etc/systemd/logind.conf```
раскомментировать и отредактировать строку:

```txt
HandleLidSwitch=ignore
```

и перезагрузить или выполнить:

```Shell
sudo restart systemd-logind
```
