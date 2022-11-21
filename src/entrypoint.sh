#!/usr/bin/env bash

echo "Setting up the user ..."

mkdir $HOME_DIR
useradd -p $(echo $PASS | openssl passwd -1 -stdin) -d $HOME_DIR $USER
chown $USER:$USER $HOME_DIR

echo "Setting up the FTP and FTPS servers ..."

server_setup='''
listen=YES
listen_ipv6=NO
write_enable=YES
pasv_enable=YES
pasv_min_port=40000
pasv_max_port=40009
chroot_local_user=YES
allow_writeable_chroot=YES'''

additional_ssl_setup='''
ssl_enable=YES
allow_anon_ssl=NO
force_local_data_ssl=NO
force_local_logins_ssl=NO
require_ssl_reuse=NO
'''

sudo cp /etc/vsftpd.conf /etc/vsftpd-ssl.conf
echo -e "$server_setup\nlisten_port=${FTP_PORT}" | sudo tee -a /etc/vsftpd.conf
echo -e "$server_setup\nlisten_port=${FTPS_PORT}\n$additional_ssl_setup" | sudo tee -a /etc/vsftpd-ssl.conf

service vsftpd restart
vsftpd /etc/vsftpd-ssl.conf &

echo "Servers set up successfully!"

if [ $IS_TRUE_RUN -eq 1 ]
then
    tail -f /dev/null
fi
