# Jarkom-Modul-1-IT26-2023

## Kelompok IT26
* Aloysius Bataona Manullang - 5027211008
* Sulthan Akmal Rafliansyah - 5027211039

## Soal 1
### Cara Pengerjaan
Pada soal diminta untuk mengetahui aktivitas yang dilakukan user dengan menggunakan protokol FTP. Maka digunakan filter `ftp.request.command`. Dan didapatkan hasil : 

![image](https://github.com/aloybm/jarkom-it26/assets/100351038/dbc7f4ee-54a0-4dd9-b23a-1e22f0fc79da)

User melakukan banyak aktivitas, tetapi terdapat satu aktivitas `STOR` yang dilakukan user, sehingga dilakukan filter untuk memastikannya `ftp.request.command == "STOR"`. Dan hasil yang didapat : 

![image](https://github.com/aloybm/jarkom-it26/assets/100351038/193f065f-d0cf-4f84-86d0-daf56c11ed9b)

Dari hasil tersebut didapatkan untuk soal 1.a.**Sequence Number (raw): 258040667** dan 1.b. **Acknowledgment number (raw): 1044861039**.

Lalu, pada soal diminta untuk mencari seq number (raw) dan ack number (raw) dari _respone_, karena _request_ berada pada paket nomor 147, sehingga kita mengetahui bahwa _respone_ berada dekat di bawah pake nomor 147 yaitu 149, dan di dapatkan hasilnya :

![image](https://github.com/aloybm/jarkom-it26/assets/100351038/5dae1800-45bb-48f4-b978-8962919c8ecd)

Sehingga didapatkan jawaban untuk nomor 1.c.**Sequence Number (raw): 1044861039** dan 1.d.**Acknowledgment number (raw): 258040696**.

![image](https://github.com/aloybm/jarkom-it26/assets/100351038/3ca69e17-dfb5-47b1-8f6b-2a86c7e12f4f)

Dengan demikian, dari jawaban yang didapatkan, maka didapatkan flag untuk nomor 1.

## Soal 2
## Cara Pengerjaan 
Pada soal diminta untuk mencari web server yang digunakan pada portal praktikum Jaringan Komputer. Untuk mencarinya maka digunkan _cli_  ` curl -i http://10.21.78.111:8000/ `.  

![image](https://github.com/aloybm/jarkom-it26/assets/100351038/28faf6fa-7bdd-4401-919e-2012b633f643)

Dari _cli_ didapatkan web server yang digunakan adalah **gunicorn**

![image](https://github.com/aloybm/jarkom-it26/assets/100351038/7cf7fc73-d737-404a-9aa9-2bb1055da8eb)

Dengan memasukkan jawabannya maka didapatkan flag untuk nomor 2.

## Soal 3
## Cara Pengerjaan 
Pada soal diminta untuk mencari jumlah banyak paket yang tercapture dengan IP source maupun destination address adalah 239.255.255.250 dengan port 3702, sehingga digunakan filter `ip.addr == 239.255.255.250 ` untuk mengetahui _protocol_ apa saja yang digunakan.

![image](https://github.com/aloybm/jarkom-it26/assets/100351038/0190cc76-f447-4c27-a1a3-2329c8c1ba55)

Dari filter yang digunakan terdapat dua protol, yaitu _SSDP_ dan _UDP_. Karena _SSDP_ tidak memiliki port sehingga protocol yang digunakan adalah _UPP_. Oleh karena itu, maka digunakan filter ``ip.addr == 239.255.255.250 && udp.port == 3702`` untuk mendapatkan jumlah paketnya dan didapatkan jumlahnya adalah **21**.

![image](https://github.com/aloybm/jarkom-it26/assets/100351038/3a83ad66-d941-4f24-ac29-1cccc0381bb1)

Dengan memasukkan jumlahnya didapatkan flag untuk nomor 3.

## Soal 4
### Cara Pengerjaan
Pada soal diminta untuk mencari berapa nilai checksum yang didapat dari header pada paket nomor 130, untuk mendapatkannya paket nomor 130 tidak perlu menggunakan filter. Nilai didapatkan dengan melakukan _scroll_ mencari nomor urut paket **130**

![image](https://github.com/aloybm/jarkom-it26/assets/100351038/97b82add-2a74-4dd6-9674-f7959c5e4e59)

Dengan hasil di atas, dicari nilai checksum dan didapatkan **Checksum: 0x18e5 [unverified]**. 

![image](https://github.com/aloybm/jarkom-it26/assets/100351038/3bebd20b-43c9-4f9c-8dde-8d9ed6aa0bbf)

Dengan memasukkan nilai checksum maka didapatkan flag untuk nomor 4.



