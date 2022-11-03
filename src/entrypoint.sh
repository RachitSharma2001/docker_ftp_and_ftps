#!/usr/bin/env bash

echo "Setting up the user ..."

if [ -z $IS_TRUE_RUN ]
then
    export USER=user
    export PASS=123
    export HOME_DIR=/home/user
    export FTP_PORT=21
    export FTPS_PORT=81
fi

mkdir $HOME_DIR
useradd -p $(echo $PASS | openssl passwd -1 -stdin) -d $HOME_DIR $USER
chown $USER:$USER $HOME_DIR

echo "Setting up the FTP and FTPS servers ..."

echo "listen=YES" >> /etc/vsftpd.conf
echo "listen_ipv6=NO" >> /etc/vsftpd.conf
echo "write_enable=YES" >> /etc/vsftpd.conf
echo "pasv_enable=YES" >> /etc/vsftpd.conf
echo "pasv_min_port=40000" >> /etc/vsftpd.conf
echo "pasv_max_port=40009" >> /etc/vsftpd.conf
echo "chroot_local_user=YES" >> /etc/vsftpd.conf
echo "allow_writeable_chroot=YES" >> /etc/vsftpd.conf

cp /etc/vsftpd.conf /etc/vsftpd-ssl.conf

echo "listen_port=${FTP_PORT}" >> /etc/vsftpd.conf
echo "listen_port=${FTPS_PORT}" >> /etc/vsftpd-ssl.conf

echo "ssl_enable=YES" >> /etc/vsftpd-ssl.conf
echo "allow_anon_ssl=NO" >> /etc/vsftpd-ssl.conf
echo "force_local_data_ssl=NO" >> /etc/vsftpd-ssl.conf
echo "force_local_logins_ssl=NO" >> /etc/vsftpd-ssl.conf
echo "require_ssl_reuse=NO" >> /etc/vsftpd-ssl.conf

service vsftpd restart
vsftpd /etc/vsftpd-ssl.conf &
echo "Servers set up successfully!"

if [ $IS_TRUE_RUN -eq 1 ]
then
    tail -f /dev/null
fi