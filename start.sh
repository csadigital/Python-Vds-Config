#!/bin/bash

# Sistem güncellemelerini yap
sudo apt-get update
sudo apt-get upgrade -y

# Nginx ve PHP kurulumu
sudo apt-get install nginx php-fpm php-mysql -y

# Python 3.9 sürümünü yükle
sudo apt-get install python3.9 -y

# Python için pip'i yükle
sudo apt-get install python3-pip -y

# Virtualenv modülünü yükle
pip3 install virtualenv

# İstediğiniz bir sanal ortam dizini oluşturun (örneğin: venv)
mkdir ~/venv
cd ~/venv

# Sanal ortamı oluşturun ve etkinleştirin
virtualenv myenv
source myenv/bin/activate

# Gerekli Python modüllerini yükleyin (örneğin: Flask ve Requests)
pip install Flask
pip install requests

# Sanal ortamı deaktive edin
deactivate

# PHPMyAdmin için gerekli olan ek paketleri yükle
sudo apt-get install php-mbstring php-zip php-gd -y

# PHPMyAdmin'i indir ve ayarla
sudo apt-get install phpmyadmin -y

# Nginx'e PHPMyAdmin'i ekleyin
echo "server {
    listen 80;
    server_name your_domain.com; # Burayı kendi alan adınıza uygun şekilde değiştirin
    root /usr/share/phpmyadmin;
    index index.php;

    location / {
        try_files \$uri \$uri/ /index.php?\$query_string;
    }

    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/var/run/php/php7.4-fpm.sock; # PHP sürümünüzü kontrol edin
    }

    location ~ /\.ht {
        deny all;
    }
}" | sudo tee /etc/nginx/sites-available/phpmyadmin

# Nginx konfigürasyonunu etkinleştirin
sudo ln -s /etc/nginx/sites-available/phpmyadmin /etc/nginx/sites-enabled/

# Nginx'i yeniden başlatın
sudo systemctl restart nginx

echo "Web sunucusu, Python, PHPMyAdmin ve Nginx başarıyla yüklendi ve yapılandırıldı."
