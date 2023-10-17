echo nameserver 192.168.122.1 > /etc/resolv.conf
apt-get update
apt-get install bind9 -y


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


mkdir /etc/bind/abimanyu
touch /etc/bind/abimanyu/abimanyu.it26.com
touch /etc/bind/abimanyu/3.246.192.in-addr.arpa

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

service bind9 restart