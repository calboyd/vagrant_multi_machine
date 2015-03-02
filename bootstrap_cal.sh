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

apt-get update
install_apache
install_nfs_server


