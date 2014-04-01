Установка веб-сервера для разработки
====================================

**(не готово)**

В настоящем руководстве кратко описан процесс установки веб-сервера
для разработки на Windows 8.1. Однако инструкция применима также
и к ранним версиями Windows.

Это руководство охватывает только мой круг интересов, не претендует
на универсальность и может оказаться бесполезным для других людей.

Опущены нюансы типа «можно использовать свой путь, ip, разрядность» и тому подобные.

nginx + apache (для старых проектов) + node.js (не готово) + python2/Django (не готово)

### Системные требования
+ Windows 7 SP1
+ Windows 8 / 8.1
+ Windows Vista SP2
+ Windows Server 2008 R2 SP1
+ Windows Server 2012 / R2

### Подготовка
1. Скачать бинарники и/или установщики:
  + [nginx/Windows-1.5.12][00] → [nginx/Windows-1.5.12][01]
  + [VC11 vcredist_x64/86.exe][02] (требуется для работы Апача)
  + [Apache][03] → [httpd-2.4.9-win64-VC11.zip][04]
  + [PHP][05] → [PHP 5.5.10 VC11 x64 Thread Safe][06]
  + [Python][07] → [Windows X86-64 MSI Installer (2.7.6)][08]
  + [Node.js][09] → [node-v0.10.26-x64.msi][010]
  + [Windows Service Wrapper][011] → [winsw-1.14-bin.exe][012]

[00]: http://nginx.org/ru/download.html "nginx"
[01]: http://nginx.org/download/nginx-1.5.12.zip
[02]: http://www.microsoft.com/en-us/download/details.aspx?id=30679 "VC11"
[03]: http://www.apachelounge.com/download
[04]: http://www.apachelounge.com/download/VC11/binaries/httpd-2.4.9-win64-VC11.zip
[05]: http://windows.php.net/download/
[06]: http://windows.php.net/downloads/releases/php-5.5.10-Win32-VC11-x64.zip
[07]: http://www.python.org/downloads/
[08]: http://www.python.org/ftp/python/2.7.6/python-2.7.6.amd64.msi
[09]: http://nodejs.org/download/
[010]: http://nodejs.org/dist/v0.10.26/x64/node-v0.10.26-x64.msi
[011]: https://github.com/kohsuke/winsw
[012]: http://repo.jenkins-ci.org/releases/com/sun/winsw/winsw/1.14/winsw-1.14-bin.exe
2. Раскидать по папкам:
  + Nginx → `c:\server\nginx`
  + WinSW → `c:\server\nginx` (и переименовать файл в nginx-service.exe)
  + Apache → `c:\server\Apache24`
  + PHP → `c:\server\php`

3. Если не установлен пакет Visual C++ для Visual Studio 2012 Update 4, установить. В лицензионной Windows 8.1 со включенным автоматическим обновлением, пакет уже должен быть установлен;

4. Создать папку для проектов → `c:\www`;

4. Создать папку для проектов, требующих Apache → `c:\www\apache`.

5. В файл `c:\Windows\System32\drivers\etc\hosts` добавить строку:
```
127.0.0.2 apache.local
```

### Nginx
1. Создать `c:\server\nginx\nginx-service.xml` с содержимым:
```xml
<service>
    <id>Nginx</id>
    <name>Nginx</name>
    <description>Nginx service</description>
    <executable>c:\server\nginx\nginx.exe</executable>
    <logpath>c:\server\nginx\logs</logpath>
    <log mode="roll-by-size">
        <sizeThreshold>10240</sizeThreshold>
        <keepFiles>2</keepFiles>
    </log>
    <startargument></startargument>
</service>
```
2. Устанавить сервис:
```
c:\server\nginx\nginx-service install
```

3. Запустить службу.
```
net start nginx
```

4. Запустить. По адресу http://localhost/ — должно быть приветствие «Welcome to nginx!».

'''Скрипты для ручного [запуска](https://github.com/icw82/storeroom/blob/master/nginx-windows/nginx-start.cmd) и [остановки](https://github.com/icw82/storeroom/blob/master/nginx-windows/nginx-stop.cmd) сервера.'''

### Nginx → Apache + PHP
1. В конфиг `c:\server\nginx\conf\nginx.gonf` добавить блок:
```conf
server {
    listen 80;
    server_name apache.local;
    location / {
        proxy_pass http://apache.local:8080/;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $remote_addr;
        proxy_connect_timeout 120;
        proxy_send_timeout 120;
        proxy_read_timeout 180;
    }

    location ~* \.(jpg|gif|png|ico|css|svg|js)$ {
        root c:/www/apache;
    }
}
```
2. Сохранить конфиг

3. Отредактировать строки в `c:\server\Apache24\conf\httpd.conf`:
  + `ServerRoot "c:/Apache24"`<br />→ `ServerRoot "c:/server/Apache24"`
  + `Listen 80` → `Listen 8080`
  + `#ServerName www.example.com:80` *(закомментирована)*<br />→ `ServerName localhost`
  + `DocumentRoot "c:/Apache24/htdocs"`<br />→ `DocumentRoot "c:/www/apache"`
  + `DirectoryIndex index.html`<br />→ `DirectoryIndex index.php index.html`
  + раскомментировать `#Include conf/extra/httpd-vhosts.conf`
  + раскомментировать `#LoadModule rewrite_module modules/mod_rewrite.so`

4. Блок `<Directory "c:/Apache24/htdocs"> … </Directory>` полностью заменить на:
```ApacheConf
<Directory "c:/www/apache">
  Options Indexes FollowSymLinks
  AllowOverride All
  Require all granted
</Directory>
```
5. В конец конфига дописать:
```conf
PHPIniDir "c:/server/php/"
LoadModule php5_module "c:/server/php/php5apache2_4.dll"
AddType application/x-httpd-php .php
```
6. Сохранить конфиг

7. Создать конфиг PHP `c:\server\php\php.ini` с содержимым:
```ini
extension_dir = "c:/server/php/ext/"
extension=php_curl.dll
extension=php_gd2.dll
extension=php_mbstring.dll
extension=php_pdo.dll
extension=php_sqlite.dll
extension=php_sqlite3.dll
```

8. Сохранить конфиг

9. Перезапустить Nginx

10. Установить и запустить Апач. Для этого нужно в командной строке (`win+R → cmd`) ввести:
```
c:\> server\Apache24\bin\httpd.exe -k install
c:\> server\Apache24\bin\httpd.exe -k start
```

#### Виртуальные хосты Apache
1. В файле `c:\server\apache\conf\extra\httpd-vhosts.conf` всё заменить на:
```conf
<VirtualHost apache.local:8080>
    DocumentRoot "c:/www/apache"
    ServerName apache.local
</VirtualHost>
```

2. Перезапустить Nginx и Apache.

### Nginx + Python + Django
1. Установить Python в папку C:\server\python27.

2. К переменой PATH добавить (если нет):
`C:\server\Python27;C:\server\Python27\Scripts;C:\server\Python27\Lib\site-packages`

3. Следуя [инструкции](https://pypi.python.org/pypi/setuptools#windows-8-powershell), установить setuptools:
```
(Invoke-WebRequest https://bitbucket.org/pypa/setuptools/raw/bootstrap/ez_setup.py).Content | python -
```

4. Установить pip:
```
easy_install pip
```

5. Установить virtualenv:
```
pip install virtualenv
```
<!--
1) Запустил редактор локальной групповой политики
2) Зашёл в раздел: Локальный компьютер `\Конфигурация компьютера\Административные шаблоны\Компоненты Windows\Windows PowerShell\`
3) Параметр `Включить выполнение сценариев` был установлен на `Не задана`, поменял на `Включена` (параметры: `Разрешить локальные сценарии...`

  .\.env\Scripts\activate.ps1

-->


### Nginx + PHP

### Nginx + Node.js

<!--![alt text](/path/to/img.jpg "Title") -->
