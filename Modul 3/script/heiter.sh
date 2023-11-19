echo 'nameserver 192.168.122.1' > /etc/resolv.conf
apt-get update
apt install bind9 -y

# Temporary
echo 'zone "riegel.canyon.it26.com" {
    type master;
    file "/etc/bind/zones/riegel.canyon.it26.com";
};

zone "granz.channel.it26.com" {
    type master;
    file "/etc/bind/zones/granz.channel.it26.com";
};

zone "1.246.192.in-addr.arpa" {
    type master;
    file "/etc/bind/zones/1.246.192.in-addr.arpa";
};' > /etc/bind/named.conf.local

mkdir -p /etc/bind/zones
touch /etc/bind/zones/riegel.canyon.it26.com
touch  /etc/bind/zones/granz.channel.it26.com
touch /etc/bind/zones/1.246.192.in-addr.arpa

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
@       IN      A       192.246.2.2     ; IP Eisen
www     IN      CNAME   riegel.canyon.it26.com.' > /etc/bind/zones/riegel.canyon.it26.com

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
@       IN      A       192.246.2.2     ; IP Eisen
www     IN      CNAME   granz.channel.it26.com.' > /etc/bind/zones/granz.channel.it26.com

echo '
; BIND reverse data file for local loopback interface
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
1       IN      PTR     riegel.canyon.it26.com.' > /etc/bind/zones/1.246.192.in-addr.arpa

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