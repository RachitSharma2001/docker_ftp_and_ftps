#!/usr/bin/env bash
mkdir $HOME_DIR
useradd -p $(echo $PASS | openssl passwd -1 -stdin) -d $HOME_DIR $USER
chown $USER:$USER $HOME_DIR

echo "listen=YES" >> /etc/vsftpd.conf
echo "listen_ipv6=NO" >> /etc/vsftpd.conf

echo "write_enable=YES" >> /etc/vsftpd.conf
echo "chroot_local_user=YES" >> /etc/vsftpd.conf
echo "allow_writeable_chroot=YES" >> /etc/vsftpd.conf
echo "pasv_enable=YES" >> /etc/vsftpd.conf
echo "pasv_max_port=40009" >> /etc/vsftpd.conf
echo "pasv_min_port=40000" >> /etc/vsftpd.conf

cp /etc/vsftpd.conf /etc/vsftpd_ssl.conf

echo "listen_port=81" >> /etc/vsftpd.conf

echo "ssl_enable=YES" >> /etc/vsftpd_ssl.conf
echo "allow_anon_ssl=NO" >> /etc/vsftpd_ssl.conf
echo "force_local_data_ssl=YES" >> /etc/vsftpd_ssl.conf
echo "force_local_logins_ssl=YES" >> /etc/vsftpd_ssl.conf

service vsftpd restart
vsftpd /etc/vsftpd_ssl.conf &
tail -f /dev/null