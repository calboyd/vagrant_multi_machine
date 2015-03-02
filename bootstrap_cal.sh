#!/usr/bin/env bash

NFS_EXPORT="/var/nfs *(rw,sync,no_root_squash,no_subtree_check)"

install_apache() {
    apt-get install -y apache2

    if ! [ -L /var/www ]; then
        rm -rf /var/www
        ln -fs /vagrant /var/www
    fi
}

install_nfs_server() {
    apt-get install -y nfs-kernel-server
    mkdir -p /var/nfs
#    chown noone:anygroup /var/nfs
    echo $NFS_EXPORT >> /etc/exports
    exportfs -a
    service nfs-kernel-server start
}

install_tftp_server() {
    apt-get install -y xinetd tftpd tftp
    cat <<START > /etc/xinetd.d/tftp 
service tftp
{
protocol	= udp
port		= 69
socket_type	= dgram
wait		= yes
user		= nobody
server		= /usr/sbin/in.tftpd
server_args	= /tftpboot
disable	= no
}
START
    mkdir /tftpboot
    chmod -R 777 /tftpboot
    /etc/init.d/xinetd restart
}

apt-get update
install_apache
install_nfs_server
install_tftp_server


