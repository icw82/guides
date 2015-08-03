Nginx + uWSGI + Django
======================

### Требования

* Nginx
* pip
* virtualenv


### Linux
```Shell
sudo mkdir /tmp/uwsgi
sudo chown www-data:www-data /tmp/uwsgi

sudo mkdir /var/www/test
cd /var/www/test
sudo mkdir ./apps
sudo mkdir ./templates
sudo mkdir ./static
sudo mkdir ./media

sudo virtualenv /var/www/test/.env
source /var/www/test/.env/bin/activate

sudo pip install django
sudo django-admin startproject core /var/www/test
```

#### Виртуальный хост Nginx

```Shell
sudo emacs /etc/nginx/sites-available/test.conf
```

```
upstream django {
    server unix:/tmp/uwsgi/test.sock;
}

server {
    listen 3000;
    server_name test;
    charset utf-8;

    client_max_body_size 100M;
    client_body_buffer_size 2M;

    location /media {
        alias /home/icw82/test/media;
    }

    location /static {
        alias /home/icw82/test/static;
    }

    location / {
        include uwsgi_params;
        uwsgi_pass django;
    }
}
```

```Shell
sudo ln -s /etc/nginx/sites-available/test.conf /etc/nginx/sites-enabled
sudo nginx -t
sudo /etc/init.d/nginx reload
```

#### test.uwsgi.ini
```ini
[uwsgi]
uid=www-data
socket = /tmp/uwsgi/test.sock
chdir = /home/icw82/test/
processes = 4
threads = 2

wsgi-file = core/wsgi.py
virtualenv=.env
pythonpath=./

stats = 127.0.0.1:9191
```

<!--
django_project_name = test
django_project_path = /var/www/%(django_project_name)/

uid = www-data
qid = www-data

socket = /tmp/uwsgi/test.sock
chdir = %(django_project_path)
processes = 4
threads = 2
master = true

virtualenv = .env
pythonpath = ./

stats = 127.0.0.1:9191
-->



Запуск:
`sudo uwsgi --ini /var/www/test/test.uwsgi.ini`


### Windows
```Shell
virtualenv .env
.\.env\Scripts\activate.ps1
python -m pip install django

chcp 65001
pip freeze > requirements.txt
pip install -r requirements.txt

django-admin startproject core ./

mkdir ./apps | mkdir ./templates | mkdir ./static | mkdir ./media

```

`python -m …`


## Общее

* Добавить в `./core/settings/py`: импорт `sys`,
  в секции приложений добавить: `sys.path.insert(0, os.path.join(BASE_DIR, 'apps'))`
  `TEMPLATE_DIRS = [os.path.join(BASE_DIR, 'templates')]`
  `STATICFILES_DIRS = [os.path.join(BASE_DIR, 'static')]`
* Предварительно создав каталог для приложения, создать приложение
  `django-admin startapp <app_label> [destination]`

* Админ `python manage.py createsuperuser`

* Добавить приложение в INSTALLED_APPS
    ```
    LANGUAGE_CODE = 'ru-ru'
    TIME_ZONE = 'Asia/Yekaterinburg'
    ```

* В файлах, где присутсвуют не-ASCII символы — `# -*- coding: utf-8 -*-`

* Миграция
  ```
  python manage.py makemigrations <app_label>
  python manage.py migrate
  ```
