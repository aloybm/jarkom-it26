# Jarkom - Modul-2-IT26-2023

## Kelompok IT26
- Aloysius Bataona Manullang - 5027211008
- Sulthan Akmal Rafliansyah - 5027211039


### Soal 1
Yudhistira akan digunakan sebagai DNS Master, Werkudara sebagai DNS Slave, Arjuna merupakan Load Balancer yang terdiri dari beberapa Web Server yaitu Prabakusuma, Abimanyu, dan Wisanggeni. Buatlah topologi dengan pembagian sebagai berikut. Folder topologi dapat diakses pada drive berikut.

#### Pengerjaan
Sesuai dengan pembagian topologi, maka kelompok IT26 mendapatkan topologi 5, alhasil sebagai berikut:
![image](https://github.com/aloybm/jarkom-it26/assets/103870239/bc4e33cd-fc37-4615-b1e5-68a45ba5e89c)

#### Detail Konfigurasi

1. Pandudewanata (Router)
```
auto eth0
iface eth0 inet dhcp

# Static config for eth1
auto eth1
iface eth1 inet static
	address 192.246.1.1
	netmask 255.255.255.0

# Static config for eth2
auto eth2
iface eth2 inet static
	address 192.246.2.1
	netmask 255.255.255.0

# Static config for eth3
auto eth3
iface eth3 inet static
	address 192.246.3.1
	netmask 255.255.255.0
```
2. Nakula (Client)
```
auto eth0
iface eth0 inet static
	address 192.246.1.2
	netmask 255.255.255.0
	gateway 192.246.1.1
```

3. Sadewa (Client)
```
auto eth0
iface eth0 inet static
	address 192.246.1.3
	netmask 255.255.255.0
	gateway 192.246.1.1
```

4. Yudhistira (DNS Master)
```
auto eth0
iface eth0 inet static
	address 192.246.2.2
	netmask 255.255.255.0
	gateway 192.246.2.1
```

5. Werkudara (DNS Slave)
```
auto eth0
iface eth0 inet static
	address 192.246.2.3
	netmask 255.255.255.0
	gateway 192.246.2.1
```

6. Arjuna (Load Balancer)
```
auto eth0
iface eth0 inet static
	address 192.246.3.2
	netmask 255.255.255.0
	gateway 192.246.3.1
```

7. Wisanggeni (Web Server)
```
auto eth0
iface eth0 inet static
	address 192.246.3.3
	netmask 255.255.255.0
	gateway 192.246.3.1
```

8. Abimanyu (Web Server)
```
auto eth0
iface eth0 inet static
	address 192.246.3.4
	netmask 255.255.255.0
	gateway 192.246.3.1
```

9. Prabukusuma (Web Server)
auto eth0
iface eth0 inet static
	address 192.246.3.5
	netmask 255.255.255.0
	gateway 192.246.3.1

#### Echoing
Setelah selesai mengkonfigurasi network, kita menambahkan command echo untuk mengubah nameserver menjadi `192.168.122.1` dengan menambahkannya ke  `.bashrc`,
Disini saya menggunakan `telnet`

Masuk le Terminal, lalu masukkan command 
`Telnet {IP}`


Pada contoh ini, saya ingin melakukan telnet ke **Yudhistira**
`Telnet {192.168.0.4:5018}`


Lalu kita melakukan echo dengan command
`echo nameserver 192.168.122.1 > /etc/resolv.conf`


Lalu kita test dengan ping ke google.com
`ping google.com`

### Soal 2
Dengan cara yang sama seperti soal nomor 2, buatlah website utama dengan akses ke arjuna.yyy.com dan alias www.arjuna.yyy.com.

Kita harus melakukan set up pada DNS Master, yaitu Yudhistira
```
echo 'zone "arjuna.it26.com" {
        type master;
        notify yes;
        also-notify { 192.246.2.3; };
        allow-transfer { 192.246.2.3; };
        file "/etc/bind/arjuna/arjuna.it26.com";
}; > /etc/bind/named.conf.local

mkdir /etc/bind/arjuna
touch /etc/bind/arjuna/arjuna.it26.com

echo '
;
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     arjuna.it26.com. root.arjuna.it26.com. (
                        2023101001      ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      arjuna.it26.com.
@       IN      A       192.246.2.2
www     IN      CNAME   arjuna.it26.com.
' > /etc/bind/arjuna/arjuna.it26.com

service bind9 restarr
```

#### Testing
```
ping arjuna.it26.com -c 5
ping www.arjuna.it26.com -c 5
```
#### Result

![image](https://github.com/aloybm/jarkom-it26/assets/100351038/3a18100c-6e2b-41cd-b585-43a593ce5343)


### Soal 3
Dengan cara yang sama seperti soal nomor 2, buatlah website utama dengan akses ke abimanyu.yyy.com dan alias www.abimanyu.yyy.com.

Kita harus melakukan set up terhadap DNS Master

```
zone "abimanyu.it26.com" {
        type master;
        notify yes;
        also-notify { 192.246.2.3; };
        allow-transfer { 192.246.2.3; };
        file "/etc/bind/abimanyu/abimanyu.it26.com";
};

mkdir /etc/bind/abimanyu
touch /etc/bind/abimanyu/abimanyu.it26.com

echo '
;
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     abimanyu.it26.com. root.abimanyu.it26.com. (
                      2023101001        ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      abimanyu.it26.com.
@       IN      A       192.246.3.4
www     IN      CNAME   abimanyu.it26.com.
' >  /etc/bind/abimanyu/abimanyu.it26.com

```
### Testing
```
ping abimanyu.it26.com -c 5
ping www.abimanyu.it26.com -c 5
```
#### Result

![image](https://github.com/aloybm/jarkom-it26/assets/100351038/97fa4491-b0bf-4d39-b763-59e02397b841)


### Soal 4 
Kemudian, karena terdapat beberapa web yang harus di-deploy, buatlah subdomain parikesit.abimanyu.yyy.com yang diatur DNS-nya di Yudhistira dan mengarah ke Abimanyu.

Kita perlu untuk menset up. Untuk subdomain, kita perlu menambahkan parikesit dengan type A yang mengarah langsung ke IP Abimanyu.

```
echo '
;
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     abimanyu.it26.com. root.abimanyu.it26.com. (
                      2023101001        ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      abimanyu.it26.com.
@       IN      A       192.246.3.4
www     IN      CNAME   abimanyu.it26.com.
parikesit       IN      A       192.246.3.4

' >  /etc/bind/abimanyu/abimanyu.it26.com
```
#### Testing
```
ping parikesit.abimanyu.it26.com -c 5
```

#### Result

![image](https://github.com/aloybm/jarkom-it26/assets/100351038/149dbe30-f3ea-4bd6-8431-7de90a1c2e8d)

### Soal 5
Buat juga reverse domain untuk domain utama. (Abimanyu saja yang direverse)

Untuk reverse domain Abimanyu, maka kita harus melakukan set up dahulu.
Berarti domain yang awalnya `192.246.3.4` di reverse menjadi `4.3.246.192`

#### Yudhistira
```
zone "3.246.192.in-addr.arpa" {
    type master;
    file "/etc/bind/abimanyu/3.246.192.in-addr.arpa";
};
' > /etc/bind/named.conf.local

echo '
;
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     abimanyu.it26.com. root.abimanyu.it26.com. (
                      2023101001        ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
3.246.192.in-addr.arpa. IN      NS      abimanyu.it26.com.
4       IN      PTR     abimanyu.it26.com'  >  /etc/bind/abimanyu/3.246.192.in-addr.arpa
```
#### Testing
```
host -t PTR 192.246.3.4 
```

#### Result

![image](https://github.com/aloybm/jarkom-it26/assets/100351038/c64a2221-c3e0-460e-a98d-ce70f16a276a)

### Soal 6
Agar dapat tetap dihubungi ketika DNS Server Yudhistira bermasalah, buat juga Werkudara sebagai DNS Slave untuk domain utama.

Kita harus melakukan setup pada DNS Master dan DNS Slave (Werkudara)

#### Yudhistira
```
echo 'zone "arjuna.it26.com" {
        type master;
        notify yes;
        also-notify { 192.246.2.3; };
        allow-transfer { 192.246.2.3; };
        file "/etc/bind/arjuna/arjuna.it26.com";
};
zone "abimanyu.it26.com" {
        type master;
        notify yes;
        also-notify { 192.246.2.3; };
        allow-transfer { 192.246.2.3; };
        file "/etc/bind/abimanyu/abimanyu.it26.com";
};

zone "3.246.192.in-addr.arpa" {
    type master;
    file "/etc/bind/abimanyu/3.246.192.in-addr.arpa";
};
' > /etc/bind/named.conf.local

// Jangan lupa restart lalu stop bind9, untuk melakukan testing slave

service bind9 restart
service bind9 stop
```

#### Werkudara
```
zone "abimanyu.it26.com" {
        type slave;
        masters { 192.246.2.2; };
        file "/var/lib/bind/abimanyu.it26.com";
}; > /etc/bind/named.conf.local
```

#### Testing
```
service bind9 stop ## Yudhisitra
ping abimanyu.it26.com -c 5
ping www.abimanyu.it26.com -c 5
```

#### Result

![image](https://github.com/aloybm/jarkom-it26/assets/100351038/80afc5f1-0ca1-44fa-b41a-705238ff679c)
![image](https://github.com/aloybm/jarkom-it26/assets/100351038/66a496f4-f5bd-4805-9d36-13464ea2a6b2)


### Soal 7
Seperti yang kita tahu karena banyak sekali informasi yang harus diterima, buatlah subdomain khusus untuk perang yaitu baratayuda.abimanyu.yyy.com dengan alias www.baratayuda.abimanyu.yyy.com yang didelegasikan dari Yudhistira ke Werkudara dengan IP menuju ke Abimanyu dalam folder Baratayuda.


Pada DNS Master kita perlu menambahkan `ns1     IN      A       192.173.2.2     ; IP Werkudara` agar mendapatkan authoritative terhadap Werkudara. Kita juga perlu mengaktifkan `allow-query { any; };` pada DNS Master.

##### Yudhistira

```
echo '
;
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     abimanyu.it26.com. root.abimanyu.it26.com. (
                      2023101001        ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      abimanyu.it26.com.
@       IN      A       192.246.3.4
www     IN      CNAME   abimanyu.it26.com.
parikesit       IN      A       192.246.3.4
nsl     IN      A       192.246.2.3
baratayuda      IN      NS      nsl
www.baratayuda     IN      NS   nsl
' >  /etc/bind/abimanyu/abimanyu.it26.com

echo "options {
    directory \"/var/cache/bind\";

    // If there is a firewall between you and nameservers you want
    // to talk to, you may need to fix the firewall to allow multiple
    // ports to talk.  See http://www.kb.cert.org/vuls/id/800113

    // If your ISP provided one or more IP addresses for stable
    // nameservers, you probably want to use them as forwarders.
    // Uncomment the following block, and insert the addresses replacing
    // the all-0's placeholder.

    // forwarders {
    //      0.0.0.0;
    // };

    //========================================================================
    // If BIND logs error messages about the root key being expired,
    // you will need to update your keys.  See https://www.isc.org/bind-keys
    //========================================================================
    //dnssec-validation auto;

    allow-query { any; };
    auth-nxdomain no;
    listen-on-v6 { any; };
};" > /etc/bind/named.conf.options
```
##### Werkudara
Pada DNS Slave Kita perlu untuk mengarahkan zone ke DNS Master agar authoritative tadi dapat jalan. Kita perlu mengaktifkan `allow-query { any; };` pada DNS Slave
```
zone "baratayuda.abimanyu.it26.com" {
        type master;
        file "/etc/bind/Baratayuda/baratayuda.abimanyu.it26.com";
};
' > /etc/bind/named.conf.local

mkdir /etc/bind/Baratayuda
touch /etc/bind/Baratayuda/baratayuda.abimanyu.it26.com
echo '
;
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     baratayuda.abimanyu.it26.com. root.baratayuda.abimanyu.it26.com. (
                     2023101001         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      baratayuda.abimanyu.it26.com.
@       IN      A       192.246.3.4
www     IN      CNAME   baratayuda.abimanyu.it26.com.
rjp     IN      A       192.246.3.4
www.rjp IN      CNAME   rjp.baratayuda.abimanyu.it26.com.
' > /etc/bind/Baratayuda/baratayuda.abimanyu.it26.com

echo "options {
    directory \"/var/cache/bind\";

    // If there is a firewall between you and nameservers you want
    // to talk to, you may need to fix the firewall to allow multiple
    // ports to talk.  See http://www.kb.cert.org/vuls/id/800113

    // If your ISP provided one or more IP addresses for stable
    // nameservers, you probably want to use them as forwarders.
    // Uncomment the following block, and insert the addresses replacing
    // the all-0's placeholder.

    // forwarders {
    //      0.0.0.0;
    // };

    //========================================================================
    // If BIND logs error messages about the root key being expired,
    // you will need to update your keys.  See https://www.isc.org/bind-keys
    //========================================================================
    //dnssec-validation auto;

    allow-query { any; };
    auth-nxdomain no;
    listen-on-v6 { any; };
};" > /etc/bind/named.conf.options

```


#### Testing
```
ping baratayuda.abimanyu.it26.com -c 5
ping www.baratayuda.abimanyu.it26.com -c 5
```

#### Result

![image](https://github.com/aloybm/jarkom-it26/assets/100351038/baa7adeb-0cc5-43fc-9e3c-a71bfd464599)


### Soal 8
Untuk informasi yang lebih spesifik mengenai Ranjapan Baratayuda, buatlah subdomain melalui Werkudara dengan akses rjp.baratayuda.abimanyu.yyy.com dengan alias www.rjp.baratayuda.abimanyu.yyy.com yang mengarah ke Abimanyu.

##### Werkudara
```
echo '
;
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     baratayuda.abimanyu.it26.com. root.baratayuda.abimanyu.it26.com. (
                     2023101001         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      baratayuda.abimanyu.it26.com.
@       IN      A       192.246.3.4
www     IN      CNAME   baratayuda.abimanyu.it26.com.
rjp     IN      A       192.246.3.4
www.rjp IN      CNAME   rjp.baratayuda.abimanyu.it26.com.
' > /etc/bind/Baratayuda/baratayuda.abimanyu.it26.com
```


#### Testing
```
ping rjp.baratayuda.abimanyu.it26.com -c 5
ping www.rjp.baratayuda.abimanyu.it26.com -c 5
```

#### Result

![image](https://github.com/aloybm/jarkom-it26/assets/100351038/a7fd7544-0d0f-4591-94ba-1db77f90dc90)

### Soal 9
Arjuna merupakan suatu Load Balancer Nginx dengan tiga worker (yang juga menggunakan nginx sebagai webserver) yaitu Prabakusuma, Abimanyu, dan Wisanggeni. Lakukan deployment pada masing-masing worker.

##### Arjuna
```
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
```

##### PrabuKusuma, Abimanyu, Wisanggeni
```
echo ' server {

 	listen 8001;

 	root /var/www/jarkom;

 	index index.php index.html index.htm;
 	server_name _;

 	location / {
 			try_files $uri $uri/ /index.php?$query_string;
 	}

 	# pass PHP scripts to FastCGI server
 	location ~ \.php$ {
 	include snippets/fastcgi-php.conf;
 	fastcgi_pass unix:/var/run/php/php7.2-fpm.sock;
 	}

 location ~ /\.ht {
 			deny all;
 	}

 	error_log /var/log/nginx/jarkom_error.log;
 	access_log /var/log/nginx/jarkom_access.log;
 }' > /etc/nginx/sites-available/jarkom

ln -s /etc/nginx/sites-available/jarkom /etc/nginx/sites-enabled/jarkom

rm /etc/nginx/sites-enabled/default

service nginx restart
```

####
#### Testing
```
lynx http://192.246.3.2
lynx http://192.246.3.5
lynx http://192.246.3.4
lynx http://192.246.3.3 
```

#### Result
![image](https://github.com/aloybm/jarkom-it26/assets/100351038/8220b24e-51bc-4592-964c-7a8e0c2eca9f)
![image](https://github.com/aloybm/jarkom-it26/assets/100351038/16cbfb4e-c133-4bd4-bf2e-f78b5c52c384)
![image](https://github.com/aloybm/jarkom-it26/assets/100351038/9ec87c86-520c-4a65-8e38-3a8d7be42e10)



### Soal 10
Kemudian gunakan algoritma Round Robin untuk Load Balancer pada Arjuna. Gunakan server_name pada soal nomor 1. Untuk melakukan pengecekan akses alamat web tersebut kemudian pastikan worker yang digunakan untuk menangani permintaan akan berganti ganti secara acak. Untuk webserver di masing-masing worker wajib berjalan di port 8001-8003. Contoh
    - Prabakusuma:8001
    - Abimanyu:8002
    - Wisanggeni:8003

##### Arjuna (Load Balancing)
```
echo 'upstream backend {
  server 192.246.3.5:8001 ; # IP PrabuKusuma
  server 192.246.3.4:8002 ; # IP Abimanyu
  server 192.246.3.3:8003 ; # IP Wisanggeni
}
```

##### PrabuKusuma, Abimanyu, Wisanggeni
X adlaah port yang ditentukan sesuai worker
```
echo ' server {

 	listen 800X;

 	root /var/www/jarkom;

 	index index.php index.html index.htm;
 	server_name _;

 	location / {
 			try_files $uri $uri/ /index.php?$query_string;
 	}

 	# pass PHP scripts to FastCGI server
 	location ~ \.php$ {
 	include snippets/fastcgi-php.conf;
 	fastcgi_pass unix:/var/run/php/php7.2-fpm.sock;
 	}

 location ~ /\.ht {
 			deny all;
 	}

 	error_log /var/log/nginx/jarkom_error.log;
 	access_log /var/log/nginx/jarkom_access.log;
 }' > /etc/nginx/sites-available/jarkom
```

#### Testing
```
lynx http://192.246.3.5:8001 
lynx http://192.246.3.4:8002
lynx http://192.246.3.3:8003 
```

#### Result
![image](https://github.com/aloybm/jarkom-it26/assets/100351038/8220b24e-51bc-4592-964c-7a8e0c2eca9f)
![image](https://github.com/aloybm/jarkom-it26/assets/100351038/16cbfb4e-c133-4bd4-bf2e-f78b5c52c384)
![image](https://github.com/aloybm/jarkom-it26/assets/100351038/9ec87c86-520c-4a65-8e38-3a8d7be42e10)


### Soal 11
Selain menggunakan Nginx, lakukan konfigurasi Apache Web Server pada worker Abimanyu dengan web server www.abimanyu.yyy.com. Pertama dibutuhkan web server dengan DocumentRoot pada /var/www/abimanyu.yyy
##### Abimanyu
```
cp /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/abimanyu.it26.com.conf

rm /etc/apache2/sites-available/000-default.conf

echo -e '<VirtualHost *:80>
  ServerAdmin webmaster@localhost
  DocumentRoot /var/www/abimanyu.it26

  ServerName abimanyu.it26.com
  ServerAlias www.abimanyu.it26.com

  ErrorLog ${APACHE_LOG_DIR}/error.log
  CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>' > /etc/apache2/sites-available/abimanyu.it26.com.conf

a2ensite abimanyu.it26.com.conf
```

#### Testing
```
lynx abimanyu.it26.com
```

#### Result

![image](https://github.com/aloybm/jarkom-it26/assets/100351038/b10fa36d-4044-4e34-946d-6161026aebb1)

### Soal 12
Setelah itu ubahlah agar url www.abimanyu.yyy.com/index.php/home menjadi www.abimanyu.yyy.com/home.
##### Abimanyu
```
echo -e '<VirtualHost *:80>
  ServerAdmin webmaster@localhost
  DocumentRoot /var/www/abimanyu.it26
  ServerName abimanyu.it26.com
  ServerAlias www.abimanyu.it26.com

  <Directory /var/www/abimanyu.it26/index.php/home>
          Options +Indexes
  </Directory>

  Alias "/home" "/var/www/abimanyu.it26/index.php/home"

  ErrorLog ${APACHE_LOG_DIR}/error.log
  CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>' > /etc/apache2/sites-available/abimanyu.it26.com.conf
```
#### Testing
```
lynx abimanyu.it26.com/home
```

#### Result

![image](https://github.com/aloybm/jarkom-it26/assets/100351038/dd88d144-d1d0-4baf-9880-514e9216cff1)


### Soal 13
Selain itu, pada subdomain www.parikesit.abimanyu.yyy.com, DocumentRoot disimpan pada /var/www/parikesit.abimanyu.yyy
##### Abimanyu
```
echo -e '<VirtualHost *:80>
  ServerAdmin webmaster@localhost
  DocumentRoot /var/www/parikesit.abimanyu.it26
  ServerName parikesit.abimanyu.it26.com
  ServerAlias www.parikesit.abimanyu.it26.com

  ErrorLog ${APACHE_LOG_DIR}/error.log
  CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>' > /etc/apache2/sites-available/parikesit.abimanyu.it26.com.conf

a2ensite parikesit.abimanyu.it26.com.conf
```

#### Testing
```
lynx parikesit.abimanyu.it26.com
```

#### Result
![image](https://github.com/aloybm/jarkom-it26/assets/100351038/f7d25ef7-5ae3-4fce-913f-5939da81603e)


### Soal 14
Pada subdomain tersebut folder /public hanya dapat melakukan directory listing sedangkan pada folder /secret tidak dapat diakses (403 Forbidden).

##### Abimanyu
```
echo -e '<VirtualHost *:80>
  ServerAdmin webmaster@localhost
  DocumentRoot /var/www/parikesit.abimanyu.it26
  ServerName parikesit.abimanyu.it26.com
  ServerAlias www.parikesit.abimanyu.it26.com

  <Directory /var/www/parikesit.abimanyu.it26/public>
          Options +Indexes
  </Directory>

  <Directory /var/www/parikesit.abimanyu.it26/secret>
          Options -Indexes
  </Directory>

  Alias "/public" "/var/www/parikesit.abimanyu.it26/public"
  Alias "/secret" "/var/www/parikesit.abimanyu.it26/secret"

  ErrorLog ${APACHE_LOG_DIR}/error.log
  CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>' > /etc/apache2/sites-available/parikesit.abimanyu.it26.com.conf
```
#### Testing
```
lynx parikesit.abimanyu.it26.com/public
lynx parikesit.abimanyu.it26.com/secret
```

#### Result
`
lynx parikesit.abimanyu.it26.com/public
`
![image](https://github.com/aloybm/jarkom-it26/assets/100351038/8ef451a5-4536-429b-8dcf-ce92db58193a)

`
lynx parikesit.abimanyu.it26.com/secret
`
![image](https://github.com/aloybm/jarkom-it26/assets/100351038/b86abd9f-93e1-4cd3-9d6c-33f0cf722ba1)
![image](https://github.com/aloybm/jarkom-it26/assets/100351038/54748964-0ecb-41e1-ae49-48bf49e23124)


### Soal 15
Buatlah kustomisasi halaman error pada folder /error untuk mengganti error kode pada Apache. Error kode yang perlu diganti adalah 404 Not Found dan 403 Forbidden.

#####  Abimanyu
```
echo -e '<VirtualHost *:80>
  ServerAdmin webmaster@localhost
  DocumentRoot /var/www/parikesit.abimanyu.it26
  ServerName parikesit.abimanyu.it26.com
  ServerAlias www.parikesit.abimanyu.it26.com

  <Directory /var/www/parikesit.abimanyu.it26/public>
          Options +Indexes
  </Directory>

  <Directory /var/www/parikesit.abimanyu.it26/secret>
          Options -Indexes
  </Directory>

  Alias "/public" "/var/www/parikesit.abimanyu.it26/public"
  Alias "/secret" "/var/www/parikesit.abimanyu.it26/secret"

  ErrorDocument 404 /error/404.html
  ErrorDocument 403 /error/403.html

  ErrorLog ${APACHE_LOG_DIR}/error.log
  CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>' > /etc/apache2/sites-available/parikesit.abimanyu.it26.com.conf
```
#### Testing
```
lynx parikesit.abimanyu.it26.com/testingerror
lynx parikesit.abimanyu.it26.com/secret
```

#### Result
##### 404 Not Found 
![image](https://github.com/aloybm/jarkom-it26/assets/100351038/70e214a7-76f6-4822-8d26-b317c8a4ba27)
![image](https://github.com/aloybm/jarkom-it26/assets/100351038/7e909850-3024-4a16-88ed-c978dee0ad1b)

##### 403 Forbidden
![image](https://github.com/aloybm/jarkom-it26/assets/100351038/b86abd9f-93e1-4cd3-9d6c-33f0cf722ba1)
![image](https://github.com/aloybm/jarkom-it26/assets/100351038/54748964-0ecb-41e1-ae49-48bf49e23124)

### Soal 16
Buatlah suatu konfigurasi virtual host agar file asset www.parikesit.abimanyu.yyy.com/public/js menjadi 
www.parikesit.abimanyu.yyy.com/js 

##### Abimanyu
```

echo -e '<VirtualHost *:80>
  ServerAdmin webmaster@localhost
  DocumentRoot /var/www/parikesit.abimanyu.it26
  ServerName parikesit.abimanyu.it26.com
  ServerAlias www.parikesit.abimanyu.it26.com

  <Directory /var/www/parikesit.abimanyu.it26/public>
          Options +Indexes
  </Directory>

  <Directory /var/www/parikesit.abimanyu.it26/secret>
          Options -Indexes
  </Directory>

  Alias "/public" "/var/www/parikesit.abimanyu.it26/public"
  Alias "/secret" "/var/www/parikesit.abimanyu.it26/secret"
  Alias "/js" "/var/www/parikesit.abimanyu.it26/public/js"

  ErrorDocument 404 /error/404.html
  ErrorDocument 403 /error/403.html

  ErrorLog ${APACHE_LOG_DIR}/error.log
  CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>' > /etc/apache2/sites-available/parikesit.abimanyu.it26.com.conf
```
#### Testing
```
lynx parikesit.abimanyu.it26.com/js
```

#### Result

![image](https://github.com/aloybm/jarkom-it26/assets/100351038/13598d57-dbe1-41a8-aa39-7c33a97f1285)


### Soal 17
Agar aman, buatlah konfigurasi agar www.rjp.baratayuda.abimanyu.yyy.com hanya dapat diakses melalui port 14000 dan 14400.

##### Abimanyu
```
echo -e '<VirtualHost *:14000 *:14400>
  ServerAdmin webmaster@localhost
  DocumentRoot /var/www/rjp.baratayuda.abimanyu.it26
  ServerName rjp.baratayuda.abimanyu.it26.com
  ServerAlias www.rjp.baratayuda.abimanyu.it26.com

  ErrorDocument 404 /error/404.html
  ErrorDocument 403 /error/403.html

  ErrorLog ${APACHE_LOG_DIR}/error.log
  CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>' > /etc/apache2/sites-available/rjp.baratayuda.abimanyu.it26.com.conf

echo -e '# If you just change the port or add more ports here, you will likely also
# have to change the VirtualHost statement in
# /etc/apache2/sites-enabled/000-default.conf

Listen 80
Listen 14000
Listen 14400

<IfModule ssl_module>
        Listen 443
</IfModule>

<IfModule mod_gnutls.c>
        Listen 443
</IfModule>

# vim: syntax=apache ts=4 sw=4 sts=4 sr noet' > /etc/apache2/ports.conf

a2ensite rjp.baratayuda.abimanyu.it26.com.conf
```
#### Testing
```
lynx rjp.baratayuda.abimanyu.it26.com:14000
lynx rjp.baratayuda.abimanyu.it26.com:14400
```

#### Result
![image](https://github.com/aloybm/jarkom-it26/assets/100351038/b03ead4f-4ae0-4bd6-97eb-a2c1dd9eecf8)
![image](https://github.com/aloybm/jarkom-it26/assets/100351038/9e2e2505-c3d0-4fbf-a0a2-d4744cf53913)




### Soal 18
Untuk mengaksesnya buatlah autentikasi username berupa “Wayang” dan password “baratayudayyy” dengan yyy merupakan kode kelompok. Letakkan DocumentRoot pada /var/www/rjp.baratayuda.abimanyu.yyy.
##### Abimanyu
```
echo -e '<VirtualHost *:14000 *:14400>
  ServerAdmin webmaster@localhost
  DocumentRoot /var/www/rjp.baratayuda.abimanyu.it26
  ServerName rjp.baratayuda.abimanyu.it26.com
  ServerAlias www.rjp.baratayuda.abimanyu.it26.com

  <Directory /var/www/rjp.baratayuda.abimanyu.it26>
          AuthType Basic
          AuthName "Restricted Content"
          AuthUserFile /etc/apache2/.htpasswd
          Require valid-user
  </Directory>

  ErrorDocument 404 /error/404.html
  ErrorDocument 403 /error/403.html

  ErrorLog ${APACHE_LOG_DIR}/error.log
  CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>' > /etc/apache2/sites-available/rjp.baratayuda.abimanyu.it26.com.conf

a2ensite rjp.baratayuda.abimanyu.it26.com.conf

htpasswd -c -b /etc/apache2/.htpasswd Wayang baratayudait26
```
#### Testing
```
lynx rjp.baratayuda.abimanyu.it26.com:14000
lynx rjp.baratayuda.abimanyu.it26.com:14400

username : Wayang
pass	: baratayudait26
```

#### Result
`
lynx rjp.baratayuda.abimanyu.it26.com:14000
`
![image](https://github.com/aloybm/jarkom-it26/assets/100351038/b03ead4f-4ae0-4bd6-97eb-a2c1dd9eecf8)
![image](https://github.com/aloybm/jarkom-it26/assets/100351038/abdac461-1786-4976-ae39-459fac23e6a8)

`
lynx rjp.baratayuda.abimanyu.it26.com:14400
`
![image](https://github.com/aloybm/jarkom-it26/assets/100351038/9e2e2505-c3d0-4fbf-a0a2-d4744cf53913)
![image](https://github.com/aloybm/jarkom-it26/assets/100351038/f57f0ec0-271f-4dd3-96fd-3ee76f1b87ff)



### Soal 19
Buatlah agar setiap kali mengakses IP dari Abimanyu akan secara otomatis dialihkan ke www.abimanyu.yyy.com (alias)

##### Abimanyu
```
echo -e '<VirtualHost *:80>
    ServerAdmin webmaster@abimanyu.it26.com
    DocumentRoot /var/www/html

    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined

    Redirect / http://www.abimanyu.it26.com/
</VirtualHost>' > /etc/apache2/sites-available/000-default.conf

apache2ctl configtest
```
#### Testing
```
lynx 192.246.3.4
```
![image](https://github.com/aloybm/jarkom-it26/assets/100351038/0ea0523b-e3fa-460b-8dbd-7f65fd433aff)

#### Result


### Soal 20
Karena website www.parikesit.abimanyu.yyy.com semakin banyak pengunjung dan banyak gambar gambar random, maka ubahlah request gambar yang memiliki substring “abimanyu” akan diarahkan menuju abimanyu.png

##### Abimanyu
```
a2enmod rewrite

echo 'RewriteEngine On
RewriteCond %{REQUEST_URI} ^/public/images/(.*)(abimanyu)(.*\.(png|jpg))
RewriteCond %{REQUEST_URI} !/public/images/abimanyu.png
RewriteRule abimanyu http://parikesit.abimanyu.it26.com/public/images/abimanyu.png$1 [L,R=301]' > /var/www/parikesit.abimanyu.it26/.htaccess

echo -e '<VirtualHost *:80>
  ServerAdmin webmaster@localhost
  DocumentRoot /var/www/parikesit.abimanyu.it26

  ServerName parikesit.abimanyu.it26.com
  ServerAlias www.parikesit.abimanyu.it26.com

  <Directory /var/www/parikesit.abimanyu.it26/public>
          Options +Indexes
  </Directory>

  <Directory /var/www/parikesit.abimanyu.it26/secret>
          Options -Indexes
  </Directory>

  <Directory /var/www/parikesit.abimanyu.it26>
          Options +FollowSymLinks -Multiviews
          AllowOverride All
  </Directory>

  Alias "/public" "/var/www/parikesit.abimanyu.it26/public"
  Alias "/secret" "/var/www/parikesit.abimanyu.it26/secret"
  Alias "/js" "/var/www/parikesit.abimanyu.it26/public/js"

  ErrorDocument 404 /error/404.html
  ErrorDocument 403 /error/403.html

  ErrorLog ${APACHE_LOG_DIR}/error.log
  CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>' > /etc/apache2/sites-available/parikesit.abimanyu.it26.com.conf
```
#### Testing
```
lynx parikesit.abimanyu.it26.com/public/images/abimanyu-student.jpg
lynx parikesit.abimanyu.it26.com/public/images/not-abimanyu.png
lynx parikesit.abimanyu.it26.com/public/images/abimanyu.png
```

#### Result
![image](https://github.com/aloybm/jarkom-it26/assets/100351038/a30fadf4-0bc8-47bc-ae74-408a899e5a5a)

### Kendala Pengerjaan
Kendala yang dialami adalah internet yang sering disconnect sehingga harus mengulang script, sehingga memakan waktu yang banyak dalam pengerjaan.



