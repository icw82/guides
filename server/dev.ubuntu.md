Установка веб-сервера для разработки
====================================

**(не готово)**

В настоящем руководстве кратко описан процесс установки
эксперементального веб-сервера для разработки под 64-разрядную Ubuntu.Server.
Однако инструкция может быть применима к другим дистрибутивам.

Это руководство охватывает только мой круг интересов, не претендует
на универсальность и может оказаться бесполезным для других людей.

### Node.js
```Shell
sudo aptitude install nodejs
sudo aptitude install npm
```

### Nginx
```Shell
aptitude install nginx
/etc/init.d/nginx start
```

### Apache
```Shell
aptitude install apache2
nano /etc/apache2/ports.conf
```
Изменить прослушиваемый порт на 8080:
```Conf
Listen 8080
```
Перезапустить Апач:
```Shell
/etc/init.d/apache2 restart
```

### Python

```Shell
wget https://bootstrap.pypa.io/ez_setup.py -O - | sudo python

sudo easy_install pip
```


### PHP

### Django
