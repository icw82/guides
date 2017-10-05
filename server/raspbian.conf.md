Памятка по настройке Raspbian
=======================================

### Права доступа и группы
```Shell
sudo groupadd admin
sudo adduser {USERNAME}
sudo gpasswd -a {USERNAME} admin
sudo visudo
```
* `%sudo` закоментировать;
* `%admin ALL=(ALL) NOPASSWD: ALL`;
* Релог.


### Настройка Wi-Fi с WPA/WPA2
https://www.raspberrypi.org/documentation/configuration/wireless/wireless-cli.md


### Компиляция nginx
https://www.linuxbabe.com/raspberry-pi/compile-nginx-source-raspbian-jessie

### HTTPS и HTTP/2
https://certbot.eff.org/#pip-nginx

sudo useradd -r nginx
sudo service nginx stop

wget https://www.openssl.org/source/openssl-1.0.2h.tar.gz
tar xvf openssl-1.0.2h.tar.gz

./configure \
--prefix=/etc/nginx \
--sbin-path=/usr/sbin/nginx \
--conf-path=/etc/nginx/nginx.conf \
--error-log-path=/var/log/nginx/error.log \
--http-log-path=/var/log/nginx/access.log \
--pid-path=/var/run/nginx.pid \
--lock-path=/var/run/nginx.lock \
--http-client-body-temp-path=/var/cache/nginx/client_temp \
--http-proxy-temp-path=/var/cache/nginx/proxy_temp \
--http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp \
--http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp \
--http-scgi-temp-path=/var/cache/nginx/scgi_temp \
--user=nginx \
--group=nginx \
--with-http_ssl_module \
--with-http_realip_module \
--with-http_addition_module \
--with-http_sub_module \
--with-http_dav_module \
--with-http_flv_module \
--with-http_mp4_module \
--with-http_gunzip_module \
--with-http_gzip_static_module \
--with-http_random_index_module \
--with-http_secure_link_module \
--with-http_stub_status_module \
--with-http_auth_request_module \
--with-mail \
--with-mail_ssl_module \
--with-file-aio \
--with-http_v2_module \
--with-ipv6 \
--with-threads \
--with-stream \
--with-stream_ssl_module \
--with-http_slice_module \
--with-openssl=/home/*********/openssl-1.0.2h

make
make install


openssl dhparam -out /etc/nginx/ssl/dhparam.pem 4096
ssl_dhparam  /etc/nginx/ssl/dhparam.pem;

### Редирект на HTTPS
https://bjornjohansen.no/redirect-to-https-with-nginx

