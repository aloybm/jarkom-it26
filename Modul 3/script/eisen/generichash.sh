##  Generic Hash
echo ' upstream worker {
    hash $request_uri consistent;
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

#ab -n 100 -c 3 -s 10 http://granz.channel.it26.com/
