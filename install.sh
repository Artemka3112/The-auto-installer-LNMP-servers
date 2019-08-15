apt-get update % apt-get upgrade
apt-get install -y sudo
sudo apt-get install -y software-properties-common
sudo add-apt-repository ppa:ondrej/php
sudo apt-get update
sudo apt-get isntall -y php7.3 php7.3-cli php7.3-fpm php7.3-json php7.3-mysql php7.3-zip php7.3-gd php7.3-mbstring php7.3-curl php7.3-xml php7.3-bcmath php7.3-common php7.3-dev php-pear php-gettext
sudo apt-get install -y curl bsdutils nginx git gcc make autoconf libc-dev pkg-config libmcrypt-dev build-essential redis-server nodejs unzip zip wget 
sudo pecl channel-update pecl.php.net
sudo pecl install mcrypt-1.0.2
sudo read -p "Пожалуйста, введите цифры похожие на дату в директории /usr/lib/php/ (20180731 - пример названия такой папки) :" dirname
sudo bash -c "echo extension=/usr/lib/php/$dirname/mcrypt.so > /etc/php/7.3/mods-available/mcrypt.ini"
sudo ln -s /etc/php/7.3/mods-available/mcrypt.ini mcrypt2.ini
sudo cp /etc/php/7.3/mods-available/mcrypt2.ini /etc/php/7.3/cli/conf.d/mcrypt.ini
sudo cp /etc/php/7.3/mods-available/mcrypt2.ini /etc/php/7.3/apache2/conf.d/mcrypt.ini
sudo rm /etc/php/7.3/mods-available/mcrypt2.ini
sudo php -i | grep mcrypt
sudo phpenmod mcrypt 
sudo service php-fpm restart
sudo service apache2 restart
sudo add-apt-repository ppa:nijel/phpmyadmin
sudo apt-get update
sudo apt-get install -q -y mysql-server phpmyadmin
sudo read -p "Пожалуйста, введите пароль для root(тот ктр будет доступен только для localhost(то-есть только для скриптов на вашем сайте)) пользователя mysql:" rootmysqlpass
sudo mysqladmin -uroot password $rootmysqlpass
sudo read -p "Пожалуйста, введите пароль для admin(будет доступен ото всюду) пользователя mysql:" adminmysqlpass
sudo echo "CREATE USER 'admin'@'%' IDENTIFIED BY '$adminmysqlpass'; GRANT ALL PRIVILEGES ON *.* TO 'admin'@'%' WITH GRANT OPTION;" | mysql -uroot -p$rootmysqlpass
sudo service mysql restart
sudo service apache2 stop
sudo apt-get purge apache2 apache2-utils apache2.2-bin apache2-common
sudo apt-get autoremove
sudo rm -rf /etc/apache2 /usr/sbin/apache2 /usr/lib/apache2 /usr/share/apache2 /var/www/html/index.php
sudo chmod -R 755 /var/www/html/
sudo reboot