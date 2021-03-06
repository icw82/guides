Установка веб-сервера для разработки
====================================

<!--
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
-->

### Подготовка
1. Скачать бинарники и/или установщики:
  + [nginx][nginx] → [nginx/Windows-1.7.4][nginx-file]
  + [Windows Service Wrapper][wsw] → [winsw-1.16-bin.exe][wsw-file]
  + [VC14 vcredist_x64/86.exe][02] (требуется для работы Апача)
  + [Apache][03] → [httpd-2.4.16-win64-VC14.zip][04]
  + [PHP][05] → [PHP 5.6.0 VC11 x64 Thread Safe][06]
  + [Node.js][09] → [node-v0.10.31-x64.msi][010]

[nginx]: http://nginx.org/ru/download.html "nginx"
[nginx-file]: http://nginx.org/download/nginx-1.7.4.zip
[wsw]: https://github.com/kohsuke/winsw
[wsw-file]: http://repo.jenkins-ci.org/releases/com/sun/winsw/winsw/1.16/winsw-1.16-bin.exe
[02]: https://www.microsoft.com/ru-RU/download/details.aspx?id=48145 "VC14"
[03]: http://www.apachelounge.com/download
[04]: http://www.apachelounge.com/download/VC11/binaries/httpd-2.4.16-win64-VC14.zip
[05]: http://windows.php.net/download/
[06]: http://windows.php.net/downloads/releases/php-5.6.0-Win32-VC11-x64.zip
[09]: http://nodejs.org/download/
[010]: http://nodejs.org/dist/v0.10.31/x64/node-v0.10.31-x64.msi

2. Раскидать по папкам:
  + Nginx → `c:\server\nginx`
  + WinSW → `c:\server\nginx` (и переименовать файл в nginx-service.exe)
  + Apache → `c:\server\Apache24`
  + PHP → `c:\server\php`

3. Если не установлен пакет Visual C++ для Visual Studio 2012 Update 4,
    установить. В лицензионной Windows 8.1 с включенным автоматическим
    обновлением, пакет уже должен быть установлен;

4. Создать папку для проектов → `c:\var\www`;

4. Создать папку для проектов, требующих Apache → `c:\var\www\apache`.

5. В файл `c:\Windows\System32\drivers\etc\hosts` добавить строку:
    ```
    127.0.0.2 *.apache
    ```
    где * — нужное доменное имя.

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


### Nginx + Node.js
1. Установить node.js в папку C:\server\nodejs.

2. для nginx добавить правило:
```conf
server {
    listen 80;
    server_name ~^(?<domain>.+?)(\.node)$;

    location / {
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header Host $http_host;
        proxy_set_header X-NginX-Proxy true;
        proxy_connect_timeout 120;
        proxy_send_timeout 120;
        proxy_read_timeout 180;

        proxy_pass http://:3000$uri$is_args$args;
        proxy_redirect off;
    }

    location /build/ {
        index index.html;
        root c:/var/www/apache/$domain;
    }
}
```

2. > npm install -g gulp

<!--
2. > npm install -g winser

3. Чтобы создать сервис, в папке с проектом: > winser -i
   всё что нужно сервис возьмёт из package.json
-->


### Nginx → Apache + PHP
1. В конфиг `c:\server\nginx\conf\nginx.gonf` добавить блок:
    ```conf
    server {
        listen 80;
        server_name ~^(?<domain>.+?)(\.apache)$;

        location / {
            proxy_pass http://127.0.0.1:8080/$domain$uri$is_args$args;
            proxy_set_header Host $host;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-For $remote_addr;
            proxy_connect_timeout 120;
            proxy_send_timeout 120;
            proxy_read_timeout 180;
        }

        location ~* \.(jpg|gif|png|ico|css|svg|js|html)$ {
            index index.html;
            root c:/var/www/apache/$domain;
        }
    }
    ```

2. Сохранить конфиг

3. Отредактировать строки в `c:\server\Apache24\conf\httpd.conf`:
  + `ServerRoot "c:/Apache24"`<br />→ `ServerRoot "c:/server/Apache24"`
  + `Listen 80` → `Listen 8080`
  + `#ServerName www.example.com:80` *(закомментирована)*<br />→ `ServerName localhost`
  + `DocumentRoot "c:/Apache24/htdocs"`<br />→ `DocumentRoot "c:/var/www/apache"`
  + `DirectoryIndex index.html`<br />→ `DirectoryIndex index.php index.html`
  + раскомментировать `#Include conf/extra/httpd-vhosts.conf`
  + раскомментировать `#LoadModule rewrite_module modules/mod_rewrite.so`

4. Блок `<Directory "c:/Apache24/htdocs"> … </Directory>` полностью заменить на:
```ApacheConf
<Directory "c:/var/www/apache">
    Options Indexes FollowSymLinks
    AllowOverride All
    Require all granted
</Directory>
```
5. В конец конфига дописать:
   ```
   PHPIniDir "c:/server/php/"
   LoadModule php5_module "c:/server/php/php5apache2_4.dll"
   AddType application/x-httpd-php .php
   ```

6. Сохранить конфиг

7. Создать конфиг PHP `c:\server\php\php.ini` с содержимым:
    ```ini
    extension_dir = "c:/server/php/ext/"
    extension=php_gd2.dll
    extension=php_mbstring.dll
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
        DocumentRoot "c:/var/www/apache"
        ServerName apache.local
    </VirtualHost>
    ```

2. Перезапустить Nginx и Apache.


### Nginx + Python + Django
<!--  + [Python][python] → [Windows X86-64 MSI Installer (2.7.9)][python-file]-->
  + [Python][python] → [Windows x86-64 MSI installer (3.4.2)][python-file]

[python]: http://www.python.org/downloads/
<!--[python-file]: https://www.python.org/ftp/python/2.7.9/python-2.7.9.amd64.msi-->
[python-file]: https://www.python.org/ftp/python/3.4.2/python-3.4.2.amd64.msi

0. Установить Python.

0. Создать переменную среды `PYTHONDIR`, соотвутсвующуую директории, куда установлен Python.
   Свойства системы — `SystemPropertiesAdvanced.exe`.

0. К переменой PATH добавить:
    `%PYTHONDIR%;%PYTHONDIR%\Scripts;%PYTHONDIR%\Lib\site-packages`

0. Следуя [инструкции](https://pypi.python.org/pypi/setuptools#windows-powershell-3-or-later),
   установить setuptools:
    ```powershell
    (Invoke-WebRequest https://bootstrap.pypa.io/ez_setup.py).Content | python -
    ```

0. Установить pip:
    ```
    easy_install pip
    ```

0. Установить virtualenv:
    ```
    pip install virtualenv
    ```

0. В редакторе локальной групповой политики `gpedit.msc`:
    ```
    Локальный компьютер
     → Конфигурация компьютера
     → Административные шаблоны
     → Компоненты Windows
     → Windows PowerShell
    ```
   Состояние `Включить выполнение сценариев` установить на `Включена`
   и определить парметр: `Разрешить локальные сценарии...`


<!--![alt text](/path/to/img.jpg "Title") -->
