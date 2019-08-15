## Автоустановщик ubuntu nginx webserver(LNMP):

### Основные задачи установщика: 
- Установка ngnix для работы сайтов.
- Установка mysql-server и phpmyadmin для работы с базой данных.
- Установка php.


### Порядок установки:
1. Заливаем файл install.sh из архива installer.zip на сервер. 
2. Запускаем его при помощи команды sh install.sh (если после выполнения программы, сервер не перезагрузится, то выполняйте все команды вручную по 1 строчке кроме 22 строчки и на 23 вместо $rootmysqlpass вводите ваш пароль для mysql. Так же и с 24 и 25 строчкой)
3. После выполнения установки переходим в директориюю /etc/nginx/sites-available и редактируем файл default
4. В блоке сервер добавляем строчки в начале и удаляем схожие не закоментированные(где нет # в начале),а так же заменяем значения на свои,
```
    listen 80;
    #listen 443 ssl;    # при использовании ssl сертификата убрать # в начале
    server_name sitename.ru;    
    #ssl_certificate            sitename.ru.crt;    # при использовании ssl сертификата указать путь к файлу с ключом и убрать # в начале
    #ssl_certificate_key        sitename.ru.key;    # при использовании ssl сертификата указать путь к файлу с ключом и убрать # в начале
    #ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
```
после такой записи: 
```
    location / {
        # First attempt to serve request as file, then
        # as directory, then fall back to displaying a 404.
        try_files $uri $uri/ =404;
    }
```
добавляем:
```
    location ~* \.php$ {
            fastcgi_pass                    unix:/var/run/php/php7.3-fpm.sock;
            fastcgi_index                   index.php;
            fastcgi_split_path_info         ^(.+\.php)(.*)$;
            include                         /etc/nginx/fastcgi_params;
            fastcgi_param                   SCRIPT_FILENAME $document_root$fastcgi_script_name;
            #fastcgi_param                  HTTPS on;   # при использовании ssl сертификата убрать # в начале
    }
    include snippets/phpmyadmin.conf;
```
и эту строчку:
```
    index index.html index.htm index.nginx-debian.html;
```
заменяем на:
```
    index index.php index.html index.htm index.nginx-debian.html;
```
далее сохраняем и закрываем файл.

5. Далее в папке snippets создаём файл phpmyadmin.conf и вписываем туда эти строки:
```
location /phpmyadmin {
    root /usr/share/;
    index index.php index.html index.htm;
    location ~ ^/phpmyadmin/(.+\.php)$ {
        try_files $uri =404;
        root /usr/share/;
        fastcgi_pass unix:/run/php/php7.3-fpm.sock;
        fastcgi_index index.php;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        include /etc/nginx/fastcgi_params;
    }

    location ~* ^/phpmyadmin/(.+\.(jpg|jpeg|gif|css|png|js|ico|html|xml|txt))$ {
        root /usr/share/;
    }
}
```
6. Выполняем команду service nginx restart.
7. И радуемся установленному серверу :)🙂

### Удаляет:
- apache2
- index.php в папке: /var/www/html

### Устанавливаемые пакеты:
- sudo
- php7.3 = PHP 7.3v с модулями(php7.3-cli php7.3-fpm php7.3-json php7.3-mysql php7.3-zip php7.3-gd php7.3-mbstring php7.3-curl php7.3-xml php7.3-bcmath php7.3-common php7.3-dev php-pear php7.3-mcrypt php-gettext)
- software-properties-common
- curl
- bsdutils
- nginx
- git
- gcc
- make
- autoconf
- libc-dev
- pkg-config
- libmcrypt-dev
- build-essential
- redis-server
- nodejs
- mysql-server
- phpmyadmin
- zip 
- unzip
- wget

### Информацию оп пакетах можно просмотреть на сайте: https://onstartup.ru

### Немного ссылок с информацией про установку ssl для nginx:
https://nginx.org/ru/docs/http/configuring_https_servers.html
https://habr.com/ru/post/195808/

### Copyright © by Artemka3112.
2019
