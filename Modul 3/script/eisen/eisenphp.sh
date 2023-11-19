# 7 dan 8
echo 'nameserver 192.246.1.2' > /etc/resolv.conf
apt-get update
apt-get install nginx -y
apt-get install lynx -y
apt-get install apache2-utils -y
service nginx start

cp /etc/nginx/sites-available/default /etc/nginx/sites-available/lb_php

echo ' upstream worker {
    server 192.246.3.1;
    server 192.246.3.2;
    server 192.246.3.3;
}

server {
    listen 80;
    server_name granz.channel.it26.com www.granz.channel.it26.com;

    root /var/www/html;

    index index.html index.htm index.nginx-debian.html;

    server_name _;

    location / {
        proxy_pass http://worker;
    }
} ' > /etc/nginx/sites-available/lb_php

ln -s /etc/nginx/sites-available/lb_php /etc/nginx/sites-enabled/
rm /etc/nginx/sites-enabled/default

service nginx restart

# 9
# Dengan menggunakan algoritma Round Robin, lakukan testing dengan menggunakan 3 worker, 2 worker, dan 1 worker sebanyak 100 request dengan 10 request/second, kemudian tambahkan grafiknya pada grimoire. (9)

# 10 Selanjutnya coba tambahkan konfigurasi autentikasi di LB dengan dengan kombinasi username: “netics
mkdir /etc/nginx/rahasisakita
htpasswd -c /etc/nginx/rahasisakita/htpasswd netics

# testing password
# Tambahkan di salah satu location -> Lalu buka url yang dituju localtion tsb

echo ' upstream worker {
    server 192.246.3.1;
    server 192.246.3.2;
    server 192.246.3.3;
}

server {
    listen 80;
    server_name granz.channel.it26.com www.granz.channel.it26.com;

    root /var/www/html;

    index index.html index.htm index.nginx-debian.html;

    server_name _;

    location / {
        proxy_pass http://worker;
        auth_basic "Restricted Content";
        auth_basic_user_file /etc/nginx/rahasisakita/htpasswd;
    }
} ' > /etc/nginx/sites-available/lb_php

ln -s /etc/nginx/sites-available/lb_php /etc/nginx/sites-enabled/
rm /etc/nginx/sites-enabled/default


# 11
# Lalu buat untuk setiap request yang mengandung /its akan di proxy passing menuju halaman https://www.its.ac.id. (11) hint: (proxy_pass)
echo 'upstream worker {
    server 192.246.3.1;
    server 192.246.3.2;
    server 192.246.3.3;
}

server {
    listen 80;
    server_name granz.channel.it26.com www.granz.channel.it26.com;

    root /var/www/html;
    index index.html index.htm index.nginx-debian.html;

    location / {
        proxy_pass http://worker;
        auth_basic "Restricted Content";
        auth_basic_user_file /etc/nginx/rahasisakita/htpasswd;
    }

    location ~ /its {
        proxy_pass https://www.its.ac.id;
        proxy_set_header Host www.its.ac.id;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}' > /etc/nginx/sites-available/lb_php


# # testing
# lynx http://192.246.2.2/its

# 12
# Selanjutnya LB ini hanya boleh diakses oleh client dengan IP [Prefix IP].3.69, [Prefix IP].3.7, [Prefix IP].4.167, dan [Prefix IP].4.168. (12)
echo 'upstream worker {
    server 192.246.3.1;
    server 192.246.3.2;
    server 192.246.3.3;
}

server {
    listen 80;
    server_name granz.channel.it26.com www.granz.channel.it26.com;

    root /var/www/html;
    index index.html index.htm index.nginx-debian.html;

    location / {
        allow 192.246.3.69;
        allow 192.246.3.70;
        allow 192.246.4.167;
        allow 192.246.4.168;
        deny all;
        proxy_pass http://worker;
        auth_basic "Restricted Content";
        auth_basic_user_file /etc/nginx/rahasisakita/htpasswd;
    }

    location ~ /its {
        proxy_pass https://www.its.ac.id;
        proxy_set_header Host www.its.ac.id;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}' > /etc/nginx/sites-available/lb_php

rm /etc/nginx/sites-available/default

service nginx restart