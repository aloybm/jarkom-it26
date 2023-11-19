apt-get update
apt-get install isc-dhcp-relay -y
service isc-dhcp-relay start

echo "SERVERS="\"192.246.1.1\""
INTERFACES="\"eth1 eth2 eth3 eth4\""
OPTIONS="\"\"" " >  /etc/default/isc-dhcp-relay

echo "net.ipv4.ip_forward=1" > /etc/sysctl.conf

service isc-dhcp-relay restart
root@Aura:~# ls
script.sh
root@Aura:~# cat script.sh
apt-get update
apt-get install isc-dhcp-relay -y
service isc-dhcp-relay start

echo "SERVERS="\"192.246.1.1\""
INTERFACES="\"eth1 eth2 eth3 eth4\""
OPTIONS="\"\"" " >  /etc/default/isc-dhcp-relay

echo "net.ipv4.ip_forward=1" > /etc/sysctl.conf

service isc-dhcp-relay restart