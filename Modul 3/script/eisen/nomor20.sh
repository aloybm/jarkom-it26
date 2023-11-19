echo 'upstream worker {
    least_conn;
    server 192.246.4.1:8001;
    server 192.246.4.2:8002;
    server 192.246.4.3:8003;
}

server {
    listen 80;
    server_name riegel.canyon.it26.com www.riegel.canyon.it26.com;

    location / {
        proxy_pass http://worker;
    }
}
' > /etc/nginx/sites-available/laravel-worker

service nginx restart