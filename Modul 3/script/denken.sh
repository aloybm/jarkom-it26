echo 'nameserver 192.173.1.2' > /etc/resolv.conf
apt-get update
apt-get install mariadb-server -y
service mysql start

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

# CREATE USER 'kelompokit26'@'%' IDENTIFIED BY 'passwordit26';
# CREATE USER 'kelompokit26'@'localhost' IDENTIFIED BY 'passwordit26';
# CREATE DATABASE dbkelompokit26;
# GRANT ALL PRIVILEGES ON *.* TO 'kelompokit26'@'%';
# GRANT ALL PRIVILEGES ON *.* TO 'kelompokit26'@'localhost';
# FLUSH PRIVILEGES;