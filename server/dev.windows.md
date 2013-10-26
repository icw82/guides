Установка веб-сервера для разработки
====================================

В настоящем руководстве кратко описан процесс установки веб-сервера
с минимальным функционалом под 64-разрядную Windows 8.1.
Однако инструкция применима также и к ранним версиями Windows.

Это руководство охватывает только мой круг интересов, не претендует
на универсальность и может оказаться бесполезным для других людей.

### Минимальные системные требования
+ Windows 7 SP1
+ Windows 8 / 8.1
+ Windows Vista SP2
+ Windows Server 2008 R2 SP1
+ Windows Server 2012 / R2 

### Инструкция
1. Скачать бинарники и/или установщики:
  + [Microsoft Visual C++ Redistributable][0] или [VC11 vcredist_x64/86.exe][01] (требуется для работы Апача)
  + [Apache][1] → [httpd-2.4.6-win64-VC11.zip][11]
  + [PHP][2] → [PHP 5.5.5 VC11 x64 Thread Safe][22]

2. Раскидать по папкам:
  + Apache → `c:\server\apache`
  + PHP → `c:\server\php`

3. Создать папку для проектов → `c:\var\www` *(в ней я создаю точки монтирования некоторых папок дропбокса)*

4. Отредактировать строки в `c:\server\apache\conf\httpd.conf`:
  + `ServerRoot "c:/Apache24"`<br />→ `ServerRoot "c:/server/apache"`
  + `#ServerName www.example.com:80` *(закомментирована)*<br />→ `ServerName localhost`
  + `DocumentRoot "c:/Apache24/htdocs"`<br />→ `DocumentRoot "c:/var/www"`
  + `DirectoryIndex index.html`<br />→ `DirectoryIndex index.php index.html`
  + раскомментировать `#Include conf/extra/httpd-vhosts.conf`
  + раскомментировать `#LoadModule rewrite_module modules/mod_rewrite.so`

5. Блок `<Directory "c:/Apache24/htdocs"> … </Directory>` полностью заменить на:
```conf
<Directory "c:/var/www">
  Options Indexes FollowSymLinks
  AllowOverride All
  Require all granted
</Directory>
```

6. В конец конфига дописать:
```conf
PHPIniDir "c:/server/php/"
LoadModule php5_module "c:/Server/php/php5apache2_4.dll"
AddType application/x-httpd-php .php
```

7. Сохранить конфиг

8. Создать конфиг PHP `c:\server\php\php.ini` с содержимым:
```ini
extension_dir = "c:/server/php/ext/"
extension=php_curl.dll
extension=php_gd2.dll
extension=php_mbstring.dll
extension=php_pdo.dll
extension=php_sqlite.dll
extension=php_sqlite3.dll
```

9. Сохранить конфиг
10. Установить и запустить Апач. Для этого нужно в командной строке (`win+R → cmd`) ввести:
```
c:\> server\apache\bin\httpd.exe -k install
c:\> server\apache\bin\httpd.exe -k start
```

###Виртуальные хосты
1. В файл `c:\Windows\System32\drivers\etc\hosts` добавить строку:
```
127.0.0.2 example.local
```

2. В файле `c:\server\apache\conf\extra\httpd-vhosts.conf` всё заменить на:
```conf
<VirtualHost *:80>
    DocumentRoot "c:/var/www/example"
    ServerName example.local
</VirtualHost>
```

[0]: http://rutracker.org/forum/viewtopic.php?t=3847203 "торрент"
[01]: http://www.microsoft.com/en-us/download/details.aspx?id=30679 "официальный"
[1]: http://www.apachelounge.com/download 
[11]: http://www.apachelounge.com/download/VC11/binaries/httpd-2.4.6-win64-VC11.zip
[2]: http://www.php.net/downloads.php
[22]: http://windows.php.net/downloads/releases/php-5.5.5-Win32-VC11-x64.zip
[3]: http://rutracker.org/forum/viewtopic.php?t=3847203

<!--![alt text](/path/to/img.jpg "Title") -->
