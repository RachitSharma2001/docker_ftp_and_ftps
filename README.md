# Local FTP and FTPS Servers

## How to use this image

### start FTP and FTPS servers on different ports

To start a container, enter the following command:

```sh
 docker run --publish 20:20/tcp --publish 40000-40009:40000-40009/tcp --publish 21:21/tcp --publish 90:90/tcp --env USER=user --env PASS=123 --env HOME_DIR=/home/user --env FTP_PORT=21 --env FTPS_PORT=90 rachitsharma2001/ftp_ftps:main
```
