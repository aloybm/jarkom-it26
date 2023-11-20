# Jarkom-Modul-3-IT26-2023

## Kelompok IT26
| Nama | NRP |
|---------------------------|------------|
| Aloysius Bataona Manullang | 5027211008 |
| Sulthan Akmal Rafliansyah | 5027211039 |

## Topologi
![image](https://github.com/aloybm/jarkom-it26/assets/103870239/93511b82-83a7-495b-9e7a-54979da80fab)


## Config
- **Aura (DHCP Relay)**
```
auto eth0
iface eth0 inet dhcp
up iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE -s 192.246.0.0/16

auto eth1
iface eth1 inet static
	address 192.246.1.0
	netmask 255.255.255.0

auto eth2
iface eth2 inet static
	address 192.246.2.0
	netmask 255.255.255.0

auto eth3
iface eth3 inet static
	address 192.246.3.0
	netmask 255.255.255.0

auto eth4
iface eth4 inet static
	address 192.246.4.0
	netmask 255.255.255.0

```
- **Himmel (DHCP Server)**
```
auto eth0
iface eth0 inet static
	address 192.246.1.1
	netmask 255.255.255.0
	gateway 192.246.1.0

```
- **Heiter (DNS Server)**
```
auto eth0
iface eth0 inet static
	address 192.246.1.2
	netmask 255.255.255.0
	gateway 192.246.1.0
```
- **Denken (Database Server)**
```
auto eth0
iface eth0 inet static
	address 192.246.2.1
	netmask 255.255.255.0
	gateway 192.246.2.0
```
- **Eisen (Load Balancer)**
```
auto eth0
iface eth0 inet static
	address 192.246.2.2
	netmask 255.255.255.0
	gateway 192.246.2.0
```
- **Frieren (Laravel Worker)**
```
auto eth0
iface eth0 inet static
	address 192.246.4.3
	netmask 255.255.255.0
	gateway 192.246.4.0

hwaddress ether 9e:d5:2c:df:39:32
```
- **Flamme (Laravel Worker)**
```
auto eth0
iface eth0 inet static
	address 192.246.4.2
	netmask 255.255.255.0
	gateway 192.246.4.0

hwaddress ether da:cc:d9:29:59:e8
```
- **Fern (Laravel Worker)**
```
auto eth0
iface eth0 inet static
	address 192.246.4.1
	netmask 255.255.255.0
	gateway 192.246.4.0

hwaddress ether 8a:31:c6:e6:a2:7b
```
- **Lawine (PHP Worker)**
```
auto eth0
iface eth0 inet static
	address 192.246.3.3
	netmask 255.255.255.0
	gateway 192.246.3.0

hwaddress ether 8e:c1:16:c2:6d:4b
```
- **Linie (PHP Worker)**
```
auto eth0
iface eth0 inet static
	address 192.246.3.2
	netmask 255.255.255.0
	gateway 192.246.3.0

hwaddress ether 7a:e7:1c:d2:ae:44
```
- **Lugner (PHP Worker)**
```
auto eth0
iface eth0 inet static
	address 192.246.3.1
	netmask 255.255.255.0
	gateway 192.246.3.0

hwaddress ether 8a:02:fd:bb:05:be
```
- **Revolte, Richter, Sein, dan Stark (Client)**
```
auto eth0
iface eth0 inet dhcp
```

### Set Up di Awal
Sebelum memulai mengerjakan soal, kita akan menginisialisasi setiap node pada `.bashrc` menggunakan `nano`

- DNS Server
  ```sh
  echo 'nameserver 192.168.122.1' > /etc/resolv.conf
  apt-get update
  apt-get install bind9 -y  
  ```
- DHCP Server
  ```sh
  echo 'nameserver 192.246.1.2' > /etc/resolv.conf  
  apt-get update
  apt install isc-dhcp-server -y
  ```
- DHCP Relay
  ```sh
  apt-get update
  apt install isc-dhcp-relay -y
  ```
- Database Server
  ```sh
  echo 'nameserver 192.246.1.2' > /etc/resolv.conf
  apt-get update
  apt-get install mariadb-server -y
  service mysql start

  Lalu jangan lupa untuk mengganti [bind-address] pada file /etc/mysql/mariadb.conf.d/50-server.cnf menjadi 0.0.0.0 dan jangan lupa untuk melakukan restart mysql kembali
  ```
- Load Balancer
  ```sh
  echo 'nameserver 192.246.1.2' > /etc/resolv.conf
  apt-get update
  apt-get install apache2-utils -y
  apt-get install nginx -y
  apt-get install lynx -y

  service nginx start
  ```
- Worker PHP
  ```sh
  echo 'nameserver 192.246.1.2' > /etc/resolv.conf
  apt-get update
  apt-get install nginx -y
  apt-get install wget -y
  apt-get install unzip -y
  apt-get install lynx -y
  apt-get install htop -y
  apt-get install apache2-utils -y
  apt-get install php7.3-fpm php7.3-common php7.3-mysql php7.3-gmp php7.3-curl php7.3-intl php7.3-mbstring php7.3-xmlrpc php7.3-gd php7.3-xml php7.3-cli php7.3-zip -y

  service nginx start
  service php7.3-fpm start
  ```
- Worker Laravel
  ```sh
  echo 'nameserver 192.246.1.2' > /etc/resolv.conf
  apt-get update
  apt-get install lynx -y
  apt-get install mariadb-client -y
  # Test connection from worker to database
  # mariadb --host=192.246.2.1 --port=3306   --user=kelompokit26 --password=passwordit26 dbkelompokit26 -e "SHOW DATABASES;"
  apt-get install -y lsb-release ca-certificates a   apt-transport-https software-properties-common gnupg2
  curl -sSLo /usr/share/keyrings/deb.sury.org-php.gpg https://packages.sury.org/php/apt.gpg
  sh -c 'echo "deb [signed-by=/usr/share/keyrings/deb.sury.org-php.gpg] https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list'
  apt-get update
  apt-get install php8.0-mbstring php8.0-xml php8.0-cli   php8.0-common php8.0-intl php8.0-opcache php8.0-readline php8.0-mysql php8.0-fpm php8.0-curl unzip wget -y
  apt-get install nginx -y

  service nginx start
  service php8.0-fpm start
  ```
- Client
  ```sh
  apt update
  apt install lynx -y
  apt install htop -y
  apt install apache2-utils -y
  apt-get install jq -y
  ```

## Soal 1 
>Lakukan konfigurasi sesuai dengan peta yang sudah diberikan.

Setelah mempersiapkan konfigurasi topologi dan melakukan [setup](#set-up-di-awal), kita perlu melakukan testing. Kita perlu menambahkan register domain berupa ``riegel.canyon.it26.com`` untuk worker Laravel dan granz.channel.it26.com untuk worker PHP yang mengarah pada worker dengan IP ``192.246.x.1``.

Note: Karena sebelumnya semua worker sudah menggunakan DHCP, maka kita perlu memodifikasi node ``Lugner`` dan ``Fern``

- **Lugner (PHP Worker)**
```
auto eth0
iface eth0 inet static
	address 192.246.3.1
	netmask 255.255.255.0
	gateway 192.246.3.0
```
- **Fern (Laravel Worker)**
```
auto eth0
iface eth0 inet static
	address 192.246.4.1
	netmask 255.255.255.0
	gateway 192.246.4.0
```

Selanjutnya pada DNS Server (Heiter), kita harus menjalankan command 

### Script
```sh
echo 'zone "riegel.canyon.it26.com" {
    type master;
    file "/etc/bind/sites/riegel.canyon.it26.com";
};

zone "granz.channel.it26.com" {
    type master;
    file "/etc/bind/sites/granz.channel.it26.com";
};

zone "1.246.192.in-addr.arpa" {
    type master;
    file "/etc/bind/sites/1.246.192.in-addr.arpa";
};' > /etc/bind/named.conf.local

mkdir -p /etc/bind/sites
cp /etc/bind/db.local /etc/bind/sites/riegel.canyon.it26.com
cp /etc/bind/db.local /etc/bind/sites/granz.channel.it26.com
cp /etc/bind/db.local /etc/bind/sites/1.246.192.in-addr.arpa

echo ';
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     riegel.canyon.it26.com. root.riegel.canyon.it26.com. (
                        2023111401      ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      riegel.canyon.it26.com.
@       IN      A       192.246.4.1     ; IP Fern
www     IN      CNAME   riegel.canyon.it26.com.' > /etc/bind/sites/riegel.canyon.it26.com

echo '
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     granz.channel.it26.com. root.granz.channel.it26.com. (
                        2023111401      ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      granz.channel.it26.com.
@       IN      A       192.246.3.1     ; IP Lugner
www     IN      CNAME   granz.channel.it26.com.' > /etc/bind/sites/granz.channel.it26.com

echo 'options {
      directory "/var/cache/bind";

      forwarders {
              192.168.122.1;
      };

      // dnssec-validation auto;
      allow-query{any;};
      auth-nxdomain no;    # conform to RFC1035
      listen-on-v6 { any; };
}; ' >/etc/bind/named.conf.options

service bind9 start
```
### Result
- ping riegel.canyon.it26.com dan ping granz.channel.it26.com
![1_Hasil](https://github.com/aloybm/jarkom-it26/assets/103870239/51505437-69cd-461d-9c44-d60955045f93)


## Soal 2
>Semua CLIENT harus menggunakan konfigurasi dari DHCP Server. Client yang melalui Switch3 mendapatkan range IP dari [prefix IP].3.16 - [prefix IP].3.32 dan [prefix IP].3.64 - [prefix IP].3.80

Setelah melakukan [setup](#set-up-di-awal) untuk DHCP Server, selanjutnya kita menjalankan command dibawah ini pada DHCP Server
### Script 
```sh
echo 'subnet 192.246.1.0 netmask 255.255.255.0 {
}

subnet 192.246.2.0 netmask 255.255.255.0 {
}

subnet 192.246.3.0 netmask 255.255.255.0 {
    range 192.246.3.16 192.246.3.32;
    range 192.246.3.64 192.246.3.80;
    option routers 192.246.3.0;
}' > /etc/dhcp/dhcpd.conf
```

## Soal 3 
>Client yang melalui Switch4 mendapatkan range IP dari [prefix IP].4.12 - [prefix IP].4.20 dan [prefix IP].4.160 - [prefix IP].4.168

Selanjutnya kita akan menambahkan konfigurasi untuk switch4 dengan menjalankan command dibawah ini

### Script 
```sh
echo 'subnet 192.246.1.0 netmask 255.255.255.0 {
}

subnet 192.246.2.0 netmask 255.255.255.0 {
}

subnet 192.246.3.0 netmask 255.255.255.0 {
    range 192.246.3.16 192.246.3.32;
    range 192.246.3.64 192.246.3.80;
    option routers 192.246.3.0;
}

subnet 192.246.4.0 netmask 255.255.255.0 {
    range 192.246.4.12 192.246.4.20;
    range 192.246.4.160 192.246.4.168;
    option routers 192.246.4.0;
} ' > /etc/dhcp/dhcpd.conf
```

## Soal 4 
>Client mendapatkan DNS dari Heiter dan dapat terhubung dengan internet melalui DNS tersebut

Untuk soal ini, kita akan menambahkan beberapa konfigurasi seperti ``option broadcast-address`` dan ``option domain-name-server`` agar dapat menggunakan DNS yang telah disiapkan sebelumnya

### Script
```sh 
subnet 192.246.3.0 netmask 255.255.255.0 {
    ...
    option broadcast-address 192.246.3.255;
    option domain-name-servers 192.246.1.2;
    ...
}

subnet 192.246.4.0 netmask 255.255.255.0 {
    option broadcast-address 192.246.4.255;
    option domain-name-servers 192.246.1.2;
}
```

Lalu kita ``shell`` script seperti berikut

```sh
echo 'subnet 192.246.1.0 netmask 255.255.255.0 {
}

subnet 192.246.2.0 netmask 255.255.255.0 {
}

subnet 192.246.3.0 netmask 255.255.255.0 {
    range 192.246.3.16 192.246.3.32;
    range 192.246.3.64 192.246.3.80;
    option routers 192.246.3.0;
    option broadcast-address 192.246.3.255;
    option domain-name-servers 192.246.1.2;
}

subnet 192.246.4.0 netmask 255.255.255.0 {
    range 192.246.4.12 192.246.4.20;
    range 192.246.4.160 192.246.4.168;
    option routers 192.246.4.0;
    option broadcast-address 192.246.4.255;
    option domain-name-servers 192.246.1.2;
} ' > /etc/dhcp/dhcpd.conf

service isc-dhcp-server start
```

Selanjutnya kita harus melakukan [setup](#set-up-di-awal) DHCP Relay terlebih dahulu. Selanjutnya kita perlu menjalankan command dibawah ini pada DHCP Relay

```sh
echo '# Defaults for isc-dhcp-relay initscript
# sourced by /etc/init.d/isc-dhcp-relay
# installed at /etc/default/isc-dhcp-relay by the maintainer scripts

#
# This is a POSIX shell fragment
#

# What servers should the DHCP relay forward requests to?
SERVERS="192.246.1.1"

# On what interfaces should the DHCP relay (dhrelay) serve DHCP requests?
INTERFACES="eth1 eth2 eth3 eth4"

# Additional options that are passed to the DHCP relay daemon?
OPTIONS=""' > /etc/default/isc-dhcp-relay

service isc-dhcp-relay start 
```

Pada file ``/etc/sysctl.conf`` kita uncomment pada ``net.ipv4.ip_forward=1``

Note:
Jangan lupa untuk restart seluruh client

### Result
    
![image](https://github.com/aloybm/jarkom-it26/assets/103870239/ac53e77b-b5b7-40d0-ae48-070389d488f4)



## Soal 5
>Lama waktu DHCP server meminjamkan alamat IP kepada Client yang melalui Switch3 selama 3 menit sedangkan pada client yang melalui Switch4 selama 12 menit. Dengan waktu maksimal dialokasikan untuk peminjaman alamat IP selama 96 menit

Kita perlu menggunakan bantuan fungsi ``default-lease-time`` dan ``max-lease-team`` dimana satuannya adalah detik.

Karena pada ``switch3`` dapat meminjamkan IP selama ``3 Menit`` dan ``Switch4`` dapat meminjamkan IP selama ``12 Menit``. Sehingga pada ``Switch3`` membutuhkan waktu ``180 s`` dan ``Switch4`` membutuhkan waktu ``720 s`` dan untuk ``max-lease-time`` nya adalah ``96 menit`` dimana akan menjadi ``5760 s``
 
Selanjutnya kita perlu menambahkan beberapa konfigurasi baru untuk mengatur leasing time pada switch3 dan switch4 sesuai dengan aturan soal. Kita dapat menjalankan command berikut pada DHCP Server

### Script
```sh
echo 'subnet 192.246.1.0 netmask 255.255.255.0 {
}

subnet 192.246.2.0 netmask 255.255.255.0 {
}

subnet 192.246.3.0 netmask 255.255.255.0 {
    range 192.246.3.16 192.246.3.32;
    range 192.246.3.64 192.246.3.80;
    option routers 192.246.3.0;
    option broadcast-address 192.246.3.255;
    option domain-name-servers 192.246.1.2;
    default-lease-time 180;
    max-lease-time 5760;
}

subnet 192.246.4.0 netmask 255.255.255.0 {
    range 192.246.4.12 192.246.4.20;
    range 192.246.4.160 192.246.4.168;
    option routers 192.246.4.0;
    option broadcast-address 192.246.4.255;
    option domain-name-servers 192.246.1.2;
    default-lease-time 720;
    max-lease-time 5760;
}

service isc-dhcp-server restart
```
### Result

![5_Hasil1](https://github.com/aloybm/jarkom-it26/assets/103870239/595228d5-49c9-48d8-acbe-84354cb8e590)

![5_Hasil2](https://github.com/aloybm/jarkom-it26/assets/103870239/91919e88-9ff8-4b11-94a2-bf93dc48ff41)


## Soal 6
> Pada setiap worker PHP, lakukan konfigurasi virtual host untuk website berikut dengan menggunakan php 7.3. (6)

Sebelum mengerjakan perlu untuk melakukan [setup](#setup-di-awal) terlebih dahulu pada **seluruh PHP Worker**. Jika sudah, silahkan untuk melakukan konfigurasi tambahan sebagai berikut untuk melakukan download dan unzip menggunakan command ``wget``
```sh
wget -O '/var/www/granz.channel.it26.com' 'https://drive.google.com/u/0/uc?id=1ViSkRq7SmwZgdK64eRbr5Fm1EGCTPrU1&export=download'
unzip -o /var/www/granz.channel.it26.com -d /var/www/
rm /var/www/granz.channel.it26.com
mv /var/www/modul-3 /var/www/granz.channel.it26.com
```

### Script
Setelah melakukan download dan unzip. Sekarang kita bisa melakukan konfigurasi pada ``nginx`` sebagai berikut:
```sh 
cp /etc/nginx/sites-available/default /etc/nginx/sites-available/granz.channel.it26.com
ln -s /etc/nginx/sites-available/granz.channel.it26.com /etc/nginx/sites-enabled/
rm /etc/nginx/sites-enabled/default

echo 'server {
    listen 80;
    server_name _;

    root /var/www/granz.channel.it26.com;
    index index.php index.html index.htm;

    location / {
        try_files $uri $uri/ /index.php?$query_string;
    }

    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/run/php/php7.3-fpm.sock;  # Sesuaikan versi PHP dan socket
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        include fastcgi_params;
    }
}' > /etc/nginx/sites-available/granz.channel.it26.com

service nginx restart
```

### Result 
Jalanin Perintah ``lynx localhost`` pada masing-masing worker dan hasilnya akan sebagai berikut:

![6](https://github.com/aloybm/jarkom-it26/assets/103870239/f5099abd-e3a2-4b31-a1ce-522c74ce4fb5)


## Soal 7
> Kepala suku dari Bredt Region memberikan resource server sebagai berikut: Lawine, 4GB, 2vCPU, dan 80 GB SSD. Linie, 2GB, 2vCPU, dan 50 GB SSD. Lugner 1GB, 1vCPU, dan 25 GB SSD. Aturlah agar Eisen dapat bekerja dengan maksimal, lalu lakukan testing dengan 1000 request dan 100 request/second. (7)

Sebelum mengerjakan perlu untuk melakukan [setup](#setup-di-awal) terlebih dahulu. Setelah melakukan konfigurasi diatas, sekarang lakukan konfigurasi ``Load Balancing`` pada node ``Eisen`` sebagai berikut 

### Script
Sebelum melakukan setup soal 7. Buka kembali Node ``DNS Server`` dan arahkan ``domain`` tersebut pada ``IP Load Balancer Eisen``

```sh
echo ';
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     riegel.canyon.it26.com. root.riegel.canyon.it26.com. (
                        2023111401      ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      riegel.canyon.it26.com.
@       IN      A       192.246.2.2     ; IP LB Eiken
www     IN      CNAME   riegel.canyon.it26.com.' > /etc/bind/sites/riegel.canyon.it26.com

echo '
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     granz.channel.it26.com. root.granz.channel.it26.com. (
                        2023111401      ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      granz.channel.it26.com.
@       IN      A       192.246.2.2     ; IP LB Eiken
www     IN      CNAME   granz.channel.it26.com.' > /etc/bind/sites/granz.channel.it26.com
```

Lalu kembali ke node ``Eisen`` dan lakukan konfigurasi pada nginx sebagai berikut

```sh 
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
```

Setelah itu lakukan [konfigurasi](#setup-di-awal) pada salah satu client. Disini kami melakukan konfigurasi pada client ``Revolte``

### Result
Jalankan perintah berikut pada client ``Revolte``
```sh
ab -n 1000 -c 100 http://www.granz.channel.it26.com/ 
```

dan akan mendapatkan hasil seperti berikut 

![image](https://github.com/aloybm/jarkom-it26/assets/103870239/95ba7ba1-2a9f-4fff-bc9a-44011440445a)

dan waktu yang dihasilkan adalah  ``Requests per second:    299.71 [#/sec] (mean)`` serta sebagai berikut, 

![image](https://github.com/aloybm/jarkom-it26/assets/103870239/a563da09-0ffa-4527-9f0f-b083c35667bf)


## Soal 8
> Karena diminta untuk menuliskan grimoire, buatlah analisis hasil testing dengan 200 request dan 10 request/second masing-masing algoritma Load Balancer dengan ketentuan sebagai berikut: 1. Nama Algoritma Load Balancer; 2. Report hasil testing pada Apache Benchmark; 3.Grafik request per second untuk masing masing algoritma; 4. Analisis

Sebelum mengerjakan perlu untuk melakukan [setup](#setup-di-awal) terlebih dahulu. Selebihnya untuk konfigurasinya sama dengan [Soal 7](#Soal-7)

Untuk laporan ``grimoire`` nya kami membuatnya di google.docs pada [link](YYYY) ini.

### Script
Jalankan command berikut pada client ``Revolte``
```sh
ab -n 200 -c 10 http://www.granz.channel.it26.com/ 
```

### Result 

**Round Robin**

![Result_Round Robin](https://github.com/aloybm/jarkom-it26/assets/103870239/e0e98802-20b0-4860-b613-afa620e0c617)



**Least-connection**

![Result_Least Connection](https://github.com/aloybm/jarkom-it26/assets/103870239/af99777f-aa92-4f88-910c-42fdaa22437a)


**IP Hash**

![Result_IP Hash](https://github.com/aloybm/jarkom-it26/assets/103870239/e8b8d056-a533-4cbe-85be-9b72e0ee7d19)


**Generic Hash**

![Result_Generic Hash](https://github.com/aloybm/jarkom-it26/assets/103870239/1c311c8d-1212-43fd-814b-d9e26c189a8b)


**Grafik**

![Request Per Second vs  Algorythm](https://github.com/aloybm/jarkom-it26/assets/103870239/ad649ffc-fbb4-47b5-a59b-3cfe3a718235)


## Soal 9
> Dengan menggunakan algoritma Round Robin, lakukan testing dengan menggunakan 3 worker, 2 worker, dan 1 worker sebanyak 100 request dengan 10 request/second, kemudian tambahkan grafiknya pada grimoire. (9)

Sebelum mengerjakan perlu untuk melakukan [setup](#setup-di-awal) terlebih dahulu. Setelah melakukan setup pada node ``Eisen`` sekarang lakukan testing pada load balancer yang telah dibuat sebelumnya. Yang menjadi pembeda adalah kita harus melakukan testing menggunakan ``1 worker``, ``2 worker``, dan ``3 worker``. 

### Script
Jalankan command berikut pada client ``Revolte``
```sh
ab -n 200 -c 10 http://www.granz.channel.it26.com/ 
```

### Result

**3 Worker**

![3_Worker](https://github.com/aloybm/jarkom-it26/assets/103870239/47c8d84c-a193-432a-a239-59ea3894c632)


> Request per second 1161.95 [#/sec] (mean)

**2 Worker**

![2_Worker](https://github.com/aloybm/jarkom-it26/assets/103870239/d8e63799-b4b2-4fe7-924d-4174acd1e6da)


> Request per second 1297.52 [#/sec] (mean)

**1 Worker**

![1_Worker](https://github.com/aloybm/jarkom-it26/assets/103870239/771849a1-2493-47c8-9093-2cb03f033b5e)


> Request per second 1410.20 [#/sec] (mean)

**Grafik**

![Graphic of Y  #_sec  (mean) vs Worker](https://github.com/aloybm/jarkom-it26/assets/103870239/e62364e5-6166-4ff9-a85d-544b225e2b6a)

## Soal 10
> Selanjutnya coba tambahkan konfigurasi autentikasi di LB dengan dengan kombinasi username: “netics” dan password: “ajkyyy”, dengan yyy merupakan kode kelompok. Terakhir simpan file “htpasswd” nya di /etc/nginx/rahasisakita/ 

Sebelum mengerjakan perlu untuk melakukan [setup](#setup-di-awal) terlebih dahulu. Setelah itu, lakukan beberapa konfigurasi sebagai berikut

### Script
```sh 
mkdir /etc/nginx/rahasisakita
htpasswd -c /etc/nginx/rahasisakita/htpasswd netics
```

Lalu, masukkan passwordnya ``ajkit26``

Jika sudah memasukkan ``password`` dan ``re-type password``. Sekarang bisa dicoba dengan menambahkan command berikut pada setup nginx.

```sh
auth_basic "Restricted Content";
auth_basic_user_file /etc/nginx/rahasisakita/htpasswd;
```

### Result
Jadi, ketika kita mengakses kembali url ``http://www.granz.channel.it26.com/`` akan menjadi unauthorized sebagai berikut 

![10_IPdeny](https://github.com/aloybm/jarkom-it26/assets/103870239/b1c6c2e0-7ccf-4646-8fef-46ed059dad13)

![10_Sukses](https://github.com/aloybm/jarkom-it26/assets/103870239/415de082-3f60-4e20-94e5-0ee44c21cb88)

![10_Sukses2](https://github.com/aloybm/jarkom-it26/assets/103870239/ee5f79e9-a54e-4833-a597-28d9e0c3dc2a)


**Setelah berhasil Autentikasi**

![10_Hasil](https://github.com/aloybm/jarkom-it26/assets/103870239/58b26332-6fa7-4a64-b00c-d30c907dc220)


## Soal 11
> Lalu buat untuk setiap request yang mengandung /its akan di proxy passing menuju halaman https://www.its.ac.id. (11) hint: (proxy_pass)

Sebelum mengerjakan perlu untuk melakukan [setup](#setup-di-awal) terlebih dahulu. Setelah itu, lakukan beberapa konfigurasi tambahan pada nginx sebagai berikut 

### Script
```sh
location ~ /its {
    proxy_pass https://www.its.ac.id;
    proxy_set_header Host www.its.ac.id;
    proxy_set_header X-Real-IP $remote_addr;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header X-Forwarded-Proto $scheme;
}
```

Berikut adalah full scriptnya 
```sh
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
    }

    location ~ /its {
        proxy_pass https://www.its.ac.id;
        proxy_set_header Host www.its.ac.id;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}' > /etc/nginx/sites-available/lb_php
```

Maksudnya adalah ketika kita melakukan akses pada endpoint yang mengandung ``/its`` akan diarahkan oleh ``proxy_pass`` menuju ``https://www.its.ac.id``. Jadi ketika melakukan testing pada client ``Revolte`` dengan menggunakan perintah berikut 

```sh
lynx www.granz.channel.it26.com/its
```

### Result

![10_Hasil](https://github.com/aloybm/jarkom-it26/assets/103870239/58b26332-6fa7-4a64-b00c-d30c907dc220)

## Soal 12
> Selanjutnya LB ini hanya boleh diakses oleh client dengan IP [Prefix IP].3.69, [Prefix IP].3.70, [Prefix IP].4.167, dan [Prefix IP].4.168. 

Sebelum mengerjakan perlu untuk melakukan [setup](#setup-di-awal) terlebih dahulu. Setelah itu, Kami hanya menambahkan beberapa konfigurasi di nginx sebagai berikut 

### Script

```sh
location / {
    allow 192.246.3.69;
    allow 192.246.3.70;
    allow 192.246.4.167;
    allow 192.246.4.168;
    deny all;
    proxy_pass http://worker;
}
```

Berikut adalah full scriptnya
```sh
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
    }

    location /its {
        proxy_pass https://www.its.ac.id;
        proxy_set_header Host www.its.ac.id;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}' > /etc/nginx/sites-available/lb_php
```

Disini kami hanya mengizinkan beberapa ``IP`` saja sesuai dengan ketentual soal dan kamu menolak seluruh ``IP`` selain yang telah ditentukan soal. Untuk melakukan testingnya. Bisa dilakukan dengan membuka client yang mendapatkan ``IP 192.246.3.69 atau 192.246.3.70 atau 192.246.4.167 atau 192.246.4.168``

### Result 

**IP Deny**

![10_IPdeny](https://github.com/aloybm/jarkom-it26/assets/103870239/1770749c-9f38-43ed-91b1-d0116216fdfb)


**IP Allow**

Menggunakan `fixed address` pada client `Richter` dimana kita bisa menambahkan konfigurasi berikut pada `dhcp server`

```sh
host Richter {
    hardware ethernet 2e:7b:e8:07:50:9f;
    fixed-address 192.246.3.69;
}'
```
Lakukan `stop` dan `start` ulang pada node `Richter`

![10_Hasil](https://github.com/aloybm/jarkom-it26/assets/103870239/58b26332-6fa7-4a64-b00c-d30c907dc220)

## Soal 13
> Semua data yang diperlukan, diatur pada Denken dan harus dapat diakses oleh Frieren, Flamme, dan Fern. (13)

Sebelum mengerjakan perlu untuk melakukan [setup](#setup-di-awal) terlebih dahulu. Setelah itu kita buka ``Database Server`` nya yaitu ``Denken`` dan lakukan konfigurasi sebagai berikut

### Script
```sh
# Db akan diakses oleh 3 worker, maka 
echo '# This group is read both by the client and the server
# use it for options that affect everything
[client-server]

# Import all .cnf files from configuration directory
!includedir /etc/mysql/conf.d/
!includedir /etc/mysql/mariadb.conf.d/

# Options affecting the MySQL server (mysqld)
[mysqld]
skip-networking=0
skip-bind-address
' > /etc/mysql/my.cnf
```

Lalu jangan lupa untuk mengubah ``[bind-address]`` pada file ``/etc/mysql/mariadb.conf.d/50-server.cnf`` menjadi ``0.0.0.0`` 

```sh 
cd /etc/mysql/mariadb.conf.d/50-server.cnf

# Changes
bind-address            = 0.0.0.0
```

Jangan lupa untuk restart mysql nya ``service mysql restart``

Setelah itu jalankan perintah berikut: 

```sh
mysql -u root -p
Enter password: 

CREATE USER 'kelompokit26'@'%' IDENTIFIED BY 'passwordit26';
CREATE USER 'kelompokit26'@'localhost' IDENTIFIED BY 'passwordit26';
CREATE DATABASE dbkelompokit26;
GRANT ALL PRIVILEGES ON *.* TO 'kelompokit26'@'%';
GRANT ALL PRIVILEGES ON *.* TO 'kelompokit26'@'localhost';
FLUSH PRIVILEGES;
```
![13_Proses](https://github.com/aloybm/jarkom-it26/assets/103870239/4f384965-1e3d-470a-b9ed-b44a01ce51b8)

### Result
Setelah itu lakukanlah pengecekan di salah satu Laravel Worker. Disini kami akan melakukan pengecekan pada worker ``Fern`` dengan melakukan perintah ``shell`` berikut

```sh
mariadb --host=192.246.2.1 --port=3306 --user=kelompokit26 --password=passwordit26 dbkelompokit26 -e "SHOW DATABASES;"
```

![13](https://github.com/aloybm/jarkom-it26/assets/103870239/f4600aff-3e27-4751-9c8d-79edc55b527c)

## Soal 14
> Frieren, Flamme, dan Fern memiliki Granz Channel sesuai dengan quest guide berikut. Jangan lupa melakukan instalasi PHP8.0 dan Composer 

Sebelum mengerjakan perlu untuk melakukan [setup](#setup-di-awal) terlebih dahulu. Setelah itu, lakukan konfigurasi lagi sebagai berikut

### Script
Lakukan install composer

```sh
wget https://getcomposer.org/download/2.0.13/composer.phar
chmod +x composer.phar
mv composer.phar /usr/local/bin/composer
```

Setelah itu install ``git`` dan lakukan cloning terhadap [resource](https://github.com/martuafernando/laravel-praktikum-jarkom) yang telah diberikan 

```sh
apt-get install git -y
cd /var/www && git clone https://github.com/martuafernando/laravel-praktikum-jarkom
cd /var/www/laravel-praktikum-jarkom && composer update
```

Setelah melakukan ``clone`` pada resource tersebut. Sekarang lakukan konfigurasi sebagai berikut pada masing-masing ``worker``

```sh 
cd /var/www/laravel-praktikum-jarkom && cp .env.example .env
echo 'APP_NAME=Laravel
APP_ENV=local
APP_KEY=
APP_DEBUG=true
APP_URL=http://localhost

LOG_CHANNEL=stack
LOG_DEPRECATIONS_CHANNEL=null
LOG_LEVEL=debug

DB_CONNECTION=mysql
DB_HOST=192.246.2.1
DB_PORT=3306
DB_DATABASE=dbkelompokit26
DB_USERNAME=kelompokit26
DB_PASSWORD=passwordit26

BROADCAST_DRIVER=log
CACHE_DRIVER=file
FILESYSTEM_DISK=local
QUEUE_CONNECTION=sync
SESSION_DRIVER=file
SESSION_LIFETIME=120

MEMCACHED_HOST=127.0.0.1

REDIS_HOST=127.0.0.1
REDIS_PASSWORD=null
REDIS_PORT=6379

MAIL_MAILER=smtp
MAIL_HOST=mailpit
MAIL_PORT=1025
MAIL_USERNAME=null
MAIL_PASSWORD=null
MAIL_ENCRYPTION=null
MAIL_FROM_ADDRESS="hello@example.com"
MAIL_FROM_NAME="${APP_NAME}"

AWS_ACCESS_KEY_ID=
AWS_SECRET_ACCESS_KEY=
AWS_DEFAULT_REGION=us-east-1
AWS_BUCKET=
AWS_USE_PATH_STYLE_ENDPOINT=false

PUSHER_APP_ID=
PUSHER_APP_KEY=
PUSHER_APP_SECRET=
PUSHER_HOST=
PUSHER_PORT=443
PUSHER_SCHEME=https
PUSHER_APP_CLUSTER=mt1

VITE_PUSHER_APP_KEY="${PUSHER_APP_KEY}"
VITE_PUSHER_HOST="${PUSHER_HOST}"
VITE_PUSHER_PORT="${PUSHER_PORT}"
VITE_PUSHER_SCHEME="${PUSHER_SCHEME}"
VITE_PUSHER_APP_CLUSTER="${PUSHER_APP_CLUSTER}"' > /var/www/laravel-praktikum-jarkom/.env
cd /var/www/laravel-praktikum-jarkom && php artisan key:generate
cd /var/www/laravel-praktikum-jarkom && php artisan config:cache
cd /var/www/laravel-praktikum-jarkom && php artisan migrate
cd /var/www/laravel-praktikum-jarkom && php artisan db:seed
cd /var/www/laravel-praktikum-jarkom && php artisan storage:link
cd /var/www/laravel-praktikum-jarkom && php artisan jwt:secret
cd /var/www/laravel-praktikum-jarkom && php artisan config:clear
chown -R www-data.www-data /var/www/laravel-praktikum-jarkom/storage
```

Setelah berhasil menjalankan semuanya dan tidak mendapatkan ``error``. Sekarang lakukan konfigurasi ``nginx`` sebagai berikut pada masing-masing worker dimana port nya adalah sebagai berikut 

```sh
192.246.4.1:8001; # Fern 
192.246.4.2:8002; # Flamme
192.246.4.3:8003; # Frieren
```

dan berikut merupakan konfigurasi ``nginx`` nya

```sh
echo 'server {
    listen <X>;

    root /var/www/laravel-praktikum-jarkom/public;

    index index.php index.html index.htm;
    server_name _;

    location / {
            try_files $uri $uri/ /index.php?$query_string;
    }

    # pass PHP scripts to FastCGI server
    location ~ \.php$ {
      include snippets/fastcgi-php.conf;
      fastcgi_pass unix:/var/run/php/php8.0-fpm.sock;
    }

    location ~ /\.ht {
            deny all;
    }

    error_log /var/log/nginx/implementasi_error.log;
    access_log /var/log/nginx/implementasi_access.log;
}' > /etc/nginx/sites-available/laravel-worker
```

dimana ``<X>`` merupakan port masing-masing Worker.


### Result
Setelah berhasil melakukan keseluruhan konfigurasi pada masing-masing ``worker``. Saatnya melakukan testing sebagai berikut

```sh
lynx localhost:[PORT]
```
dimana PORT yang ada adalah ``8001`` ``8002`` dan ``8003``. Sesuaikan dengan setup nginx sebelumnya.

![14_Masuk](https://github.com/aloybm/jarkom-it26/assets/103870239/a5a979d7-cb04-4e71-a3ae-a53374748829)



## Soal 15
> Granz Channel memiliki beberapa endpoint yang harus ditesting sebanyak 100 request dengan 10 request/second. Tambahkan response dan hasil testing pada grimoire. Untuk POST /api/auth/register

Untuk mengerjakan soal ini. Diperlukan melakukan testing menggunakan ``Apache Benchmark`` pada salah satu worker saja. Disini kami akan menggunakan worker laravel ``Fern`` yang nantinya akan menjadi worker yang akan ditesting oleh client ``Revolte``. Sebelum dilakukan testing, kami menggunakan bantuan file ``.json`` yang akan digunakan sebagai ``body`` yang akan dikirim pada endpoint ``/api/auth/register`` nantinya sebagai berikut

### Script
```sh
echo '
{
  "username": "kelompokit26",
  "password": "passwordit26",
}' > register.json
```

Lalu, lakukanlah perintah berikut dari sisis client ``Revolte`` 
```sh
ab -n 100 -c 10 -p register.json -T application/json http://192.246.4.1:8001/api/auth/register
```

### Result

![15](https://github.com/aloybm/jarkom-it26/assets/103870239/60b2acba-41bf-43b0-98d3-11ae75bd761e)

## Soal 16
> Granz Channel memiliki beberapa endpoint yang harus ditesting sebanyak 100 request dengan 10 request/second. Tambahkan response dan hasil testing pada grimoire. Untuk POST /api/auth/login 

Untuk mengerjakan soal ini. Diperlukan melakukan testing menggunakan ``Apache Benchmark`` pada salah satu worker saja. Disini kami akan menggunakan worker laravel ``Fern`` yang nantinya akan menjadi worker yang akan ditesting oleh client ``Revolte``. Sebelum dilakukan testing, kami menggunakan bantuan file ``.json`` yang akan digunakan sebagai ``body`` yang akan dikirim pada endpoint ``/api/auth/login`` nantinya sebagai berikut

### Script
```sh
echo '
{
  "username": "kelompokit26",
  "password": "passwordit26",
}' > login.json
```

Lalu, lakukanlah perintah berikut dari sisis client ``Revolte`` 
```sh
ab -n 100 -c 10 -p login.json -T application/json http://192.246.4.1:8001/api/auth/login
```

### Result

![16](https://github.com/aloybm/jarkom-it26/assets/103870239/52a9d5dd-8af8-4c4f-9a3f-604b1859be4c)


## Soal 17
> Granz Channel memiliki beberapa endpoint yang harus ditesting sebanyak 100 request dengan 10 request/second. Tambahkan response dan hasil testing pada grimoire. Untuk GET /api/me


Untuk mengerjakan soal ini. Diperlukan melakukan testing menggunakan ``Apache Benchmark`` pada salah satu worker saja. Disini kami akan menggunakan worker laravel ``Fern`` yang nantinya akan menjadi worker yang akan ditesting oleh client ``Revolte``. Sebelum dilakukan testing. Ada beberapa konfigurasi yang harus disiapkan sebagai berikut 

### Script
Dapatkan tokennya terlebih dahulu sebelum mengakses endpoint ``/api/me``

```sh
curl -X POST -H "Content-Type: application/json" -d @login.json http://192.246.4.1:8001/api/auth/login > login_output.txt
```

Lalu jalankan perintah berikut untuk melakukan set ``token`` secara global

```sh
token=$(cat login_output.txt | jq -r '.token')
```

Setelah itu jalankan perintah berikut untuk melakukan testing

```sh
ab -n 100 -c 10 -H "Authorization: Bearer $token" http://192.246.4.1:8001/api/me
```

### Result 
Terdapat error dalam pengiriman sebanyak 100 request. Karena satu worker saja tidak kuat untuk mendapatkan request sebanyak itu 100 dalam waktu yang telah diberikan atau dengan kata lain CPU yang diterima tidak sanggup untuk memproses banyaknya request. Sehingga menyebabkan hanya ``62`` request saja yang berhasil di proses sedangkan ``38`` lainnya tidak berhasil di proses

![17](https://github.com/aloybm/jarkom-it26/assets/103870239/70de57e3-aa65-4ba0-9cdd-c4c47e2ed6c3)


## Soal 18
> Untuk memastikan ketiganya bekerja sama secara adil untuk mengatur Granz Channel maka implementasikan Proxy Bind pada Eisen untuk mengaitkan IP dari Frieren, Flamme, dan Fern. 

Sebelum mengerjakan perlu untuk melakukan [setup](#setup-di-awal) terlebih dahulu. Setelah itu, karena hanya diberikan perintah ketiga ``worker`` berjalan secara adil, kami memberikan implementasi dari ``Load Balancing`` karena sesuai dengan definisi nya yaitu membagi rata beban kerja. Maka dari itu, berikut merupakan konfigurasi ``nginx``

### Script
```sh
echo 'upstream worker {
    server 192.246.4.1:8001;
    server 192.246.4.2:8002;
    server 192.246.4.3:8003;
}

server {
    listen 80;
    server_name granz.channel.it26.com www.granz.channel.it26.com;

    location / {
        proxy_pass http://worker;
    }
} 
' > /etc/nginx/sites-available/laravel-worker

ln -s /etc/nginx/sites-available/laravel-worker /etc/nginx/sites-enabled/laravel-worker

service nginx restart
```

**Notes**
Hati-hati ``port`` tabrakan dengan ``load balancer`` dari ``php worker`` 

### Result
Setelah melakukan konfigurasi pada ``load balancer`` pada ``Eisen``. Sekarang waktunya melakukan testing pada client ``Revolte`` dengan menjalankan perintah berikut 

```sh
ab -n 100 -c 10 -p login.json -T application/json http://www.granz.channel.it26.com/api/auth/login
```

Hasilnya adalah sebagai berikut!

![18_Hasil](https://github.com/aloybm/jarkom-it26/assets/103870239/6327661f-764e-4318-8825-31c698562a03)


**Fern**

![18_Fern](https://github.com/aloybm/jarkom-it26/assets/103870239/81deeaa0-4dd1-4b10-8fcb-6bd63843ea27)


**Flamme**

![18_Flame](https://github.com/aloybm/jarkom-it26/assets/103870239/2f717d51-0f87-4677-a9af-4fdb34792535)


**Frieren**

![Fieren](https://github.com/aloybm/jarkom-it26/assets/103870239/088592c2-da02-46d0-bc6e-517d471e97ae)


## Soal 19
> Untuk meningkatkan performa dari Worker, coba implementasikan PHP-FPM pada Frieren, Flamme, dan Fern. Untuk testing kinerja naikkan -> pm.max_children, pm.start_servers, pm.min_spare_servers, pm.max_spare_servers sebanyak tiga percobaan dan lakukan testing sebanyak 100 request dengan 10 request/second kemudian berikan hasil analisisnya pada Grimoire.

Untuk mengerjakan soal ini terdapat beberapa penjelasan sebagai berikut 

**pm.max_children** 
Menentukan jumlah maksimum pekerja PHP (proses anak) yang dapat berjalan secara bersamaan. Nilai ini sebaiknya disesuaikan dengan kapasitas sumber daya server. Jika terlalu rendah, server mungkin tidak dapat menangani banyak permintaan secara bersamaan, sementara jika terlalu tinggi, dapat menyebabkan kelebihan beban dan kekurangan sumber daya.

**pm.start_servers**
Menentukan jumlah pekerja PHP yang akan dimulai secara otomatis ketika PHP-FPM pertama kali dijalankan atau direstart. Ini membantu dalam mengoptimalkan performa pada saat server pertama kali dimulai.

**pm.min_spare_servers**
Menentukan jumlah minimum pekerja PHP yang tetap berjalan saat server berjalan. Ini membantu menjaga agar server tetap responsif terhadap permintaan bahkan saat lalu lintas rendah.

**pm.max_spare_servers** Menentukan jumlah maksimum pekerja PHP yang dapat berjalan tetapi tidak menangani permintaan. Jumlah ini disesuaikan dengan kebutuhan untuk menangani lonjakan lalu lintas tanpa menambahkan terlalu banyak sumber daya ketika beban rendah.

Akan ada 4 konfigurasi terhadap proses ``package manager`` pada masing-masing worker yang nantinya akan dilakukan untuk testing.

### Script

**Script 1**
```sh
# Setup Awal
echo '[www]
user = www-data
group = www-data
listen = /run/php/php8.0-fpm.sock
listen.owner = www-data
listen.group = www-data
php_admin_value[disable_functions] = exec,passthru,shell_exec,system
php_admin_flag[allow_url_fopen] = off

; Choose how the process manager will control the number of child processes.

pm = dynamic
pm.max_children = 5
pm.start_servers = 2
pm.min_spare_servers = 1
pm.max_spare_servers = 3' > /etc/php/8.0/fpm/pool.d/www.conf

service php8.0-fpm restart
```

**Script 2**
```sh
echo '[www]
user = www-data
group = www-data
listen = /run/php/php8.0-fpm.sock
listen.owner = www-data
listen.group = www-data
php_admin_value[disable_functions] = exec,passthru,shell_exec,system
php_admin_flag[allow_url_fopen] = off

; Choose how the process manager will control the number of child processes.

pm = dynamic
pm.max_children = 25
pm.start_servers = 5
pm.min_spare_servers = 3
pm.max_spare_servers = 10' > /etc/php/8.0/fpm/pool.d/www.conf

service php8.0-fpm restart
```

**Script 3**
```sh
echo '[www]
user = www-data
group = www-data
listen = /run/php/php8.0-fpm.sock
listen.owner = www-data
listen.group = www-data
php_admin_value[disable_functions] = exec,passthru,shell_exec,system
php_admin_flag[allow_url_fopen] = off

; Choose how the process manager will control the number of child processes.

pm = dynamic
pm.max_children = 50
pm.start_servers = 8
pm.min_spare_servers = 5
pm.max_spare_servers = 15' > /etc/php/8.0/fpm/pool.d/www.conf

service php8.0-fpm restart
```

**Script 4**
```sh
echo '[www]
user = www-data
group = www-data
listen = /run/php/php8.0-fpm.sock
listen.owner = www-data
listen.group = www-data
php_admin_value[disable_functions] = exec,passthru,shell_exec,system
php_admin_flag[allow_url_fopen] = off

; Choose how the process manager will control the number of child processes.

pm = dynamic
pm.max_children = 75
pm.start_servers = 10
pm.min_spare_servers = 5
pm.max_spare_servers = 20' > /etc/php/8.0/fpm/pool.d/www.conf

service php8.0-fpm restart
```

### Result

**Script 1**

![19_Script 1](https://github.com/aloybm/jarkom-it26/assets/103870239/880e085e-66a7-4660-9587-e7382d98bcb7)


**Script 2**

![19_Script 2](https://github.com/aloybm/jarkom-it26/assets/103870239/885a33fd-ae14-4446-bf06-55c821e875a8)


**Script 3**

![19)_Script 3](https://github.com/aloybm/jarkom-it26/assets/103870239/89f89e63-3322-4d6c-90af-492d219a1521)


**Script 4**

![19_Script 4](https://github.com/aloybm/jarkom-it26/assets/103870239/38a56e90-b1ec-4463-9f06-43241b28cd1e)


## Soal 20
> Nampaknya hanya menggunakan PHP-FPM tidak cukup untuk meningkatkan performa dari worker maka implementasikan Least-Conn pada Eisen. Untuk testing kinerja dari worker tersebut dilakukan sebanyak 100 request dengan 10 request/second. (20)

Karena proses yang telah di ``konfigurasi`` sebelumnya pada masing-masing worker tepatnya pada ``package manager`` dan ternyata hasil yang diberikan juga tidak cukup untuk meningkatkan performa ``worker``. Oleh karena itu, ditambahkan ``algoritma`` pada ``load balancer`` tersebut dengan menggunakan ``Least-connection`` dimana algoritma ini akan melakukan prioritas pembagian dari beban kinerja yang paling rendah. Node master akan mencatat semua beban dan kinerja dari semua node, dan akan melakukan prioritas dari beban yang paling rendah. Sehingga diharapkan tidak ada server dengan beban yang rendah.

### Script
```sh
echo 'upstream worker {
    least_conn;
    server 192.246.4.1:8001;
    server 192.246.4.2:8002;
    server 192.246.4.3:8003;
}

server {
    listen 80;
    server_name granz.channel.it26.com www.granz.channel.it26.com;

    location / {
        proxy_pass http://worker;
    }
} 
' > /etc/nginx/sites-available/laravel-worker

service nginx restart
```

**Notes** 
Disini kami masih menggunakan ``setup`` pada ``package manager`` sebagai berikut 

```sh
pm = dynamic
pm.max_children = 75
pm.start_servers = 10
pm.min_spare_servers = 5
pm.max_spare_servers = 20
```

### Result
Jika ditambahkan Algoritma ``Load Balancing Least-connection``. Hasil yang didapatkan cukup ``signifikan`` sebagai berikut 

![20](https://github.com/aloybm/jarkom-it26/assets/103870239/6965bfdd-d7f9-4f66-98f1-9bcd90950e3e)


Kesimpulannnya, algoritma ``Least-connection`` dapat berkerja dengan baik.

