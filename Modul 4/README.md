# Jarkom-Modul-3-IT26-2023

## Kelompok IT26
| Nama | NRP |
|---------------------------|------------|
| Aloysius Bataona Manullang | 5027211008 |
| Sulthan Akmal Rafliansyah | 5027211039 |

### Topologi 
![image](https://github.com/aloybm/jarkom-it26/assets/100351038/c6b49f03-a5be-4727-bf9c-40dd7cb82553)

### VLSM
Berdasarkan topologi, maka pada VLSM perlu dilakukan pembagian Subnet pada Class A.
#### Topologi pada CPT

![vlsm](https://github.com/aloybm/jarkom-it26/assets/100351038/7d8bce93-ece6-4d09-9ec0-d4c108ad99e5)

#### Subnetting
Berdarkan topologi tersebut maka dilakukan perhituhan jumlah IP bedarkan jumlah kebutuhan PC dan Router. Hasilnya seperti di bawah ini :

| Nama Subnet | Rute                                              | Jumlah IP | Netmask |
|-------------|---------------------------------------------------|-----------|---------|
| A5          | Aura-Frieren-Flamme-Fern-Switch4-LaubHills-Swi...| 1023      | /21     |
| A6          | Aura-Frieren-Flamme-Switch5-RohrRoad             | 1001      | /22     |
| A13         | Aura-Eisen-LugnerSwitch10-TurkRegion             | 1001      | /22     |
| A18         | Aura-Eisen-Linie-Lawine-Heiter-Switch8-Sein-Sw...| 512       | /22     |
| A19         | Aura-Eisen-Linie-Switch11-GranzChannel           | 255       | /23     |
| A14         | Aura-Eisen-Lugner-Switch9-GrobeForest            | 251       | /24     |
| A21         | Aura-Denken-Switch2-RoyalCapital-Switch2-Wille...| 127       | /24     |
| A17         | Aura-Eisen-Linie-Lawine-Heiter-Switch7-BredtRe...| 31        | /26     |
| A2          | Aura-Frieren-Switch3-LakeKorridor                | 25        | /27     |
| A8          | Aura-Frieren-Flamme-Himmel-Switch6-SchwerMount...| 6         | /29     |
| A10         | Aura-Eisen-Switch1-Richter-Switch1-Revolte       | 3         | /29     |
| A1          | Aura-Frieren                                      | 2         | /30     |
| A3          | Aura-Frieren-Flamme                               | 2         | /30     |
| A4          | Aura-Frieren-Flamme-Fern                          | 2         | /30     |
| A7          | Aura-Frieren-Flamme-Himmel                        | 2         | /30     |
| A9          | Aura-Eisen                                        | 2         | /30     |
| A11         | Aura-Eisen-Switch0-Stark                          | 2         | /30     |
| A12         | Aura-Eisen-Lugner                                 | 2         | /30     |
| A15         | Aura-Eisen-Linie                                  | 2         | /30     |
| A16         | Aura-Eisen-Linie-Lawine                           | 2         | /30     |
| A20         | Aura-Denken                                       | 2         | /30     |
| Total       |                                                   | 4255      | /19     |


Beradasarkan tabel di atas, didapatkan bahwa yang mencangkupi host tersebut dengan lenght /19.

##### VLSM TREE 
Subnet besar yang dibentuk memiliki NID 192.246.0.0 dengan netmask /19. Hitung pembagian IP berdasarkan NID dan netmask tersebut menggunakan pohon seperti gambar di bawah.
![VLSM (4)](https://github.com/aloybm/jarkom-it26/assets/100351038/9ed3c61c-a5b2-4436-a155-347da4097bd0)

Dari pohon dari pohon tersebut akan mendapat pembagian IP sebagai berikut.

| Subnet | Network ID    | Netmask           | Broadcast        |
|--------|---------------|-------------------|------------------|
| A5     | 192.246.0.0   | 255.255.248.0     | 192.246.7.255   |
| A6     | 192.246.8.0   | 255.255.252.0     | 192.246.11.255  |
| A13    | 192.246.12.0  | 255.255.252.0     | 192.246.15.255  |
| A18    | 192.246.16.0  | 255.255.252.0     | 192.246.19.255  |
| A19    | 192.246.20.0  | 255.255.254.0     | 192.246.21.255  |
| A14    | 192.246.22.0  | 255.255.255.0     | 192.246.22.255  |
| A21    | 192.246.23.0  | 255.255.255.0     | 192.246.23.255  |
| A17    | 192.246.24.0  | 255.255.255.192   | 192.246.24.63   |
| A2     | 192.246.24.64 | 255.255.255.224   | 192.246.24.95   |
| A8     | 192.246.24.96 | 255.255.255.248   | 192.246.24.103  |
| A10    | 192.246.24.104| 255.255.255.248   | 192.246.24.111  |
| A1     | 192.246.24.112| 255.255.255.252   | 192.246.24.115  |
| A3     | 192.246.24.116| 255.255.255.252   | 192.246.24.119  |
| A4     | 192.246.24.120| 255.255.255.252   | 192.246.24.123  |
| A7     | 192.246.24.124| 255.255.255.252   | 192.246.24.127  |
| A9     | 192.246.24.128| 255.255.255.252   | 192.246.24.131  |
| A11    | 192.246.24.132| 255.255.255.252   | 192.246.24.135  |
| A12    | 192.246.24.136| 255.255.255.252   | 192.246.24.139  |
| A15    | 192.246.24.140| 255.255.255.252   | 192.246.24.143  |
| A16    | 192.246.24.144| 255.255.255.252   | 192.246.24.147  |
| A20    | 192.246.24.148| 255.255.255.252   | 192.246.24.151  |

Network id, Netmask, dan Broadcast disesuaikan dengan length subnetnya masing masing. Setalah didapatkan pembagian maka dapat diimplementasi Routing pada CPT. Berikut merupakan salah satu contoh konfigruasi dari Aura : 
![image](https://github.com/aloybm/jarkom-it26/assets/100351038/d2b96184-f0f3-4f2a-904b-675906d601aa)
![image](https://github.com/aloybm/jarkom-it26/assets/100351038/38046ccd-54fb-41ec-8cd8-697d7ff1f67d)

Jika konfigurasi dengan benar maka hasilnya akan Successfull. Berikut contoh dari Fern ke Lugner :

![image](https://github.com/aloybm/jarkom-it26/assets/100351038/fb5fa25f-2f88-4d91-a327-8aaf051cd8a4)

### CIDR

CIDR menggunakan GNS3, memerlukan proses Penggabungan Topologi

#### Penggabungan Topologi
##### Tahap 1 (A)
![image](https://github.com/aloybm/jarkom-it26/assets/103870239/8b9c318e-3186-471f-9275-7198ccb82f87)

##### Tahap 2 (B)
![image](https://github.com/aloybm/jarkom-it26/assets/103870239/1dd91084-fa5f-4327-b4d2-c0a569f74f71)

##### Tahap 3 (C)
![image](https://github.com/aloybm/jarkom-it26/assets/103870239/174516ea-6eb6-431b-a0eb-e034ff73777d)

##### Tahap 4 (D)
![image](https://github.com/aloybm/jarkom-it26/assets/103870239/39ee5d29-926d-4617-8fce-4e25df8cbae1)

##### Tahap 5 (E)
![image](https://github.com/aloybm/jarkom-it26/assets/103870239/3fee9155-f36f-4cbd-8c19-884e8446e6d2)

##### Tahap 6 (F)
![image](https://github.com/aloybm/jarkom-it26/assets/103870239/8eddf86d-ad61-4bdc-aa9b-115dd8bcf607)

##### Tahap 7 (G)
![image](https://github.com/aloybm/jarkom-it26/assets/103870239/95a539b1-c27f-43ec-9c7b-ff4df291d66e)

##### Tahap 8 (H)
![image](https://github.com/aloybm/jarkom-it26/assets/103870239/1a768976-30c1-4811-bc1d-0fa7061c3b9a)

##### Tahap 9 (I)
![image](https://github.com/aloybm/jarkom-it26/assets/103870239/e8efbb77-eeee-4516-ab05-ae6d98cbf525)

##### Penggambaran 
![I](https://github.com/aloybm/jarkom-it26/assets/103870239/0c0906aa-d3bc-4fb7-8845-d16303477609)

#### Tree 
![Tree_Fix](https://github.com/aloybm/jarkom-it26/assets/103870239/5e442d8a-5f5b-4c9a-8630-7830d7363e7e)

#### Pembagian IP CIDR
![image](https://github.com/aloybm/jarkom-it26/assets/103870239/752b90f2-9098-46f0-adfc-71d83924409f)

### Routing
Melakukan konfigurasi pada gns


#### Kendala
Kendala yang dialami adalah dibutuhkan kefokuskan agar pada konfigurasi tidak terjadi kesalahan.

