echo nameserver 192.168.122.1 > /etc/resolv.conf
apt update
apt-get install bind9 -y

echo 'zone "arjuna.it26.com" {
        type slave;
        masters { 192.246.2.2; };
        file "/var/lib/bind/arjuna.it26.com";
};

zone "abimanyu.it26.com" {
        type slave;
        masters { 192.246.2.2; };
        file "/var/lib/bind/abimanyu.it26.com";
};

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

service bind9 restart