#!/usr/bin/env bash
mkdir /home/user
useradd -p $(echo "123" | openssl passwd -1 -stdin) -d /home/user user
chown user:user /home/user
#echo "listen=YES\nlisten_ipv6=NO \n write_enable=YES listen_port=81 \n pasv_enable=YES \n pasv_max_port=10100 \n pasv_min_port=10090 \n chroot_local_user=YES \n allow_writeable_chroot=YES" >> /etc/vsftpd.conf
#echo -e "write_enable=YES\nchroot_local_user=YES\nallow_writeable_chroot=YES" >> /etc/vsftpd.conf
echo "listen=YES" >> /etc/vsftpd.conf
echo "listen_ipv6=NO" >> /etc/vsftpd.conf

echo "write_enable=YES" >> /etc/vsftpd.conf
echo "chroot_local_user=YES" >> /etc/vsftpd.conf
echo "allow_writeable_chroot=YES" >> /etc/vsftpd.conf

cp /etc/vsftpd.conf /etc/vsftpd_ssl.conf

echo "listen_port=81" >> /etc/vsftpd.conf
echo "pasv_enable=YES" >> /etc/vsftpd.conf
echo "pasv_max_port=10100" >> /etc/vsftpd.conf
echo "pasv_min_port=10090" >> /etc/vsftpd.conf

echo "ssl_enable=YES" >> /etc/vsftpd_ssl.conf
echo "allow_anon_ssl=NO" >> /etc/vsftpd_ssl.conf
echo "force_local_data_ssl=YES" >> /etc/vsftpd_ssl.conf
echo "force_local_logins_ssl=YES" >> /etc/vsftpd_ssl.conf

service vsftpd restart
vsftpd /etc/vsftpd_ssl.conf &
tail -f /dev/null