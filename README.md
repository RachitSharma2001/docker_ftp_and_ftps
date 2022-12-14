# Local FTP and FTPS Servers

There are a wide variety of docker images that set up either one FTP server or one FTPS server. However, none of them allow for both an FTP and FTPS server to be locally set up. This can be useful in the niche situation where you need both servers, such as if you need to set up tests for both an FTP and FTPS server and don't want to go through the headache of manually setting up everything through vsftpd.

## How to use this image

To start a container, enter the following command:

```sh
 docker run \
    --publish 20-21:20-21/tcp \
    --publish 40000-40009:40000-40009/tcp \
    --publish 90:90/tcp \
    --env USER=user \
    --env PASS=123 \
    --env HOME_DIR=/home/user \
    --env FTP_PORT=21 \
    --env FTPS_PORT=90 \
    rachitsharma2001/ftp_ftps
```

Note: you can set up the FTP and FTPS ports anywhere on the local image and map them to any of the ports on your local computer. The above example sets up an FTP server on port 21 of the docker image and maps your local computer's port 21 to that server within the image. It also sets up an FTPS server on port 90 of the docker image and maps it to your local computer's port 90. But you can use any open ports on your computer and the docker image

## You can edit the following to your own needs:

| Variable      | Values | Description                                                      | Default      |
| ------------- | ------ | ---------------------------------------------------------------- | ------------ |
| `USER`        | string | name of user to connect to both FTP, FTPS servers                | `user`       |
| `PASS`        | string | password of specified user                                       | `123`        |
| `HOME_DIR`    | string | name of home directory of the created user                       | `/home/user` |
| `FTP_PORT`    | int    | port (within docker image) where FTP server will be ran          | 21           |
| `FTPS_PORT`   | int    | port (within docker image) where FTPS server will be ran         | 21           |
