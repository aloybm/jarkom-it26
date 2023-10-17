echo 'nameserver 192.168.122.1' > /etc/resolv.conf
apt-get update
apt-get install php -y
apt install nginx php php-fpm -y

echo 'upstream backend {
  server 192.246.3.5:8001 ; # IP PrabuKusuma
  server 192.246.3.4:8002 ; # IP Abimanyu
  server 192.246.3.3:8003 ; # IP Wisanggeni
}

server {
  listen 80;
  server_name arjuna.it26.com www.arjuna.it26.com;

  location / {
    proxy_pass http://backend;
  }
}
' > /etc/nginx/sites-available/jarkom

ln -s /etc/nginx/sites-available/jarkom /etc/nginx/sites-enabled/jarkom

rm /etc/nginx/sites-enabled/default

service nginx restart