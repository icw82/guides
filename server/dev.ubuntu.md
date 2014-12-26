Пмаятка по веб-серверу для разработки
=====================================

### Nginx
```Shell
sudo aptitude install nginx
sudo /etc/init.d/nginx start
emacs /etc/nginx/nginx.conf
```

```Conf
user www-data;
worker_processes 2;
pid /run/nginx.pid;

events {
    worker_connections 768;
    use epoll;
    # multi_accept on;
}

http {
    ## Basic Settings

    sendfile on;
    tcp_nopush on;
    tcp_nodelay on;
    keepalive_timeout 65; #75 20
    types_hash_max_size 2048;
    # server_tokens off;
    # server_names_hash_bucket_size 64;
    # server_name_in_redirect off;

    include /etc/nginx/mime.types;
    default_type application/octet-stream;


    ignore_invalid_headers on;

    client_header_timeout 10m;
    client_body_timeout 10m;
    send_timeout 10m;

    client_max_body_size 512m;
    connection_pool_size 256;
    client_header_buffer_size 1k;
    large_client_header_buffers 4 2k;
    request_pool_size 4k;

    output_buffers 1 32k;
    postpone_output 1460;


    ## Logging Settings
    access_log /var/log/nginx/access.log;
    error_log /var/log/nginx/error.log;

    log_format main
        '$remote_addr - $remote_user [$time_local] '
        '"$request" $status $bytes_sent '
        '"$http_referer" "$http_user_agent" '
        '"$gzip_ratio"';


    ## Gzip Settings
    gzip on;
    gzip_disable "msie6";

    # gzip_vary on;
    # gzip_proxied any;
    gzip_comp_level 1;
    gzip_buffers 16 8k;
    gzip_min_length 1100;
    # gzip_http_version 1.1;
    gzip_types text/plain text/css application/json application/javascript text/xml application/xml application/xml+rss text/javascript;


    ## nginx-naxsi config
    ##(защита от XSS, SQL-инъекций, CSRF, Local & Remote file inclusions)
    #include /etc/nginx/naxsi_core.rules;


    ## nginx-passenger config (для ruby)
    #passenger_root /usr;
    #passenger_ruby /usr/bin/ruby;


    ## Virtual Host Configs
    include /etc/nginx/conf.d/*.conf;
    include /etc/nginx/sites-enabled/*;
}
```


### Python + pip + virtualenv + uwsgi
```Shell
sudo aptitude install build-essential python-dev
wget https://bootstrap.pypa.io/ez_setup.py -O - | sudo python
sudo easy_install pip
sudo pip install virtualenv
sudo pip install uwsgi
```

### git
```Shell
sudo aptitude install git
```


### Node.js
```Shell
sudo aptitude install nodejs
sudo aptitude install npm
```


<!--
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
-->

### Рабочие каталоги
```
sudo mkdir /var/www
sudo chown www-data:www-data /var/www/
```

### PHP
