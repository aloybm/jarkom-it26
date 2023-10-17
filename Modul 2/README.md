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

#### Testing
```
ping arjuna.it26.com -c 5
ping www.arjuna.it26.com -c 5
```
#### Result

![image](https://github.com/aloybm/jarkom-it26/assets/100351038/bfa1524b-3646-480f-a61b-2d090204c7c2)


### Soal 3
Dengan cara yang sama seperti soal nomor 2, buatlah website utama dengan akses ke abimanyu.yyy.com dan alias www.abimanyu.yyy.com.

### Testing
```
ping abimanyu.it26.com -c 5
ping www.abimanyu.it26.com -c 5
```
#### Result

![image](https://github.com/aloybm/jarkom-it26/assets/100351038/97fa4491-b0bf-4d39-b763-59e02397b841)


### Soal 4 
Kemudian, karena terdapat beberapa web yang harus di-deploy, buatlah subdomain parikesit.abimanyu.yyy.com yang diatur DNS-nya di Yudhistira dan mengarah ke Abimanyu.

#### Testing
```
ping parikesit.abimanyu.it26.com -c 5
```

#### Result

![image](https://github.com/aloybm/jarkom-it26/assets/100351038/149dbe30-f3ea-4bd6-8431-7de90a1c2e8d)

### Soal 5
Buat juga reverse domain untuk domain utama. (Abimanyu saja yang direverse)

#### Testing
```
host -t PTR 192.246.3.4 
```

#### Result

![image](https://github.com/aloybm/jarkom-it26/assets/100351038/c64a2221-c3e0-460e-a98d-ce70f16a276a)

### Soal 6
Agar dapat tetap dihubungi ketika DNS Server Yudhistira bermasalah, buat juga Werkudara sebagai DNS Slave untuk domain utama.

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

#### Testing
```
ping baratayuda.abimanyu.it26.com -c 5
ping www.baratayuda.abimanyu.it26.com -c 5
```

#### Result



### Soal 8
Untuk informasi yang lebih spesifik mengenai Ranjapan Baratayuda, buatlah subdomain melalui Werkudara dengan akses rjp.baratayuda.abimanyu.yyy.com dengan alias www.rjp.baratayuda.abimanyu.yyy.com yang mengarah ke Abimanyu.


#### Testing
```
```

#### Result



### Soal 9
Arjuna merupakan suatu Load Balancer Nginx dengan tiga worker (yang juga menggunakan nginx sebagai webserver) yaitu Prabakusuma, Abimanyu, dan Wisanggeni. Lakukan deployment pada masing-masing worker.


#### Testing
```
```

#### Result


### Soal 10
Kemudian gunakan algoritma Round Robin untuk Load Balancer pada Arjuna. Gunakan server_name pada soal nomor 1. Untuk melakukan pengecekan akses alamat web tersebut kemudian pastikan worker yang digunakan untuk menangani permintaan akan berganti ganti secara acak. Untuk webserver di masing-masing worker wajib berjalan di port 8001-8003. Contoh
    - Prabakusuma:8001
    - Abimanyu:8002
    - Wisanggeni:8003

#### Testing
```
```

#### Result



### Soal 11
Selain menggunakan Nginx, lakukan konfigurasi Apache Web Server pada worker Abimanyu dengan web server www.abimanyu.yyy.com. Pertama dibutuhkan web server dengan DocumentRoot pada /var/www/abimanyu.yyy

#### Testing
```
```

#### Result



### Soal 12
Setelah itu ubahlah agar url www.abimanyu.yyy.com/index.php/home menjadi www.abimanyu.yyy.com/home.

#### Testing
```
```

#### Result


### Soal 13
Selain itu, pada subdomain www.parikesit.abimanyu.yyy.com, DocumentRoot disimpan pada /var/www/parikesit.abimanyu.yyy

#### Testing
```
```

#### Result


### Soal 14
Pada subdomain tersebut folder /public hanya dapat melakukan directory listing sedangkan pada folder /secret tidak dapat diakses (403 Forbidden).

#### Testing
```
```

#### Result


### Soal 15
Buatlah kustomisasi halaman error pada folder /error untuk mengganti error kode pada Apache. Error kode yang perlu diganti adalah 404 Not Found dan 403 Forbidden.

#### Testing
```
```

#### Result


### Soal 16
Buatlah suatu konfigurasi virtual host agar file asset www.parikesit.abimanyu.yyy.com/public/js menjadi 
www.parikesit.abimanyu.yyy.com/js 

#### Testing
```
```

#### Result


### Soal 17
Agar aman, buatlah konfigurasi agar www.rjp.baratayuda.abimanyu.yyy.com hanya dapat diakses melalui port 14000 dan 14400.

#### Testing
```
```

#### Result


### Soal 18
Untuk mengaksesnya buatlah autentikasi username berupa “Wayang” dan password “baratayudayyy” dengan yyy merupakan kode kelompok. Letakkan DocumentRoot pada /var/www/rjp.baratayuda.abimanyu.yyy.

#### Testing
```
```

#### Result


### Soal 19
Buatlah agar setiap kali mengakses IP dari Abimanyu akan secara otomatis dialihkan ke www.abimanyu.yyy.com (alias)

#### Testing
```
```

#### Result


### Soal 20
Karena website www.parikesit.abimanyu.yyy.com semakin banyak pengunjung dan banyak gambar gambar random, maka ubahlah request gambar yang memiliki substring “abimanyu” akan diarahkan menuju abimanyu.png

#### Testing
```
```

#### Result


