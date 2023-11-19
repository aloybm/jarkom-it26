echo 'nameserver 192.246.1.2' > /etc/resolv.conf
apt-get update
apt install isc-dhcp-server -y
# 2
echo 'subnet 192.246.1.0 netmask 255.255.255.0 {
}

subnet 192.246.2.0 netmask 255.255.255.0 {
}

subnet 192.246.3.0 netmask 255.255.255.0 {
    range 192.246.3.16 192.246.3.32;
    range 192.246.3.64 192.246.3.80;
    option routers 192.246.3.0;
}' > /etc/dhcp/dhcpd.conf

# 3
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



# 5
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

host Lawine {
    hardware ethernet 56:57:33:ee:2a:29;
    fixed-address 192.246.3.3;
}

host Linie {
    hardware ethernet e2:78:b6:ae:a6:0f;
    fixed-address 192.246.3.2;
}

host Lunger {
    hardware ethernet 3a:f0:30:fe:bc:bd;
    fixed-address 192.246.3.1;
}

host Frieren {
    hardware ethernet a2:04:d8:5b:12:7e;
    fixed-address 192.246.4.3;
}

host Flamme {
    hardware ethernet 1e:4c:44:6f:a7:73;
    fixed-address 192.246.4.2;
}

host Fern {
    hardware ethernet a6:e1:57:d2:2e:e6;
    fixed-address 192.246.4.1;
}

host Richter {
    hardware ethernet 2e:7b:e8:07:50:9f;
    fixed-address 192.246.3.69;
}' > /etc/dhcp/dhcpd.conf

echo 'INTERFACESv4="eth0"' > /etc/default/isc-dhcp-server

service isc-dhcp-server start