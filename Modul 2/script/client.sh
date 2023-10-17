echo -e '
nameserver 192.245.2.3
nameserver 192.246.2.2
nameserver 192.168.122.1' > /etc/resolv.conf
apt-get update
apt-get install dnsutils -y
apt-get install lynx -y

