FROM ubuntu:latest

ENV USER=user \
    PASS=123 \
    HOME_DIR=/home/user
COPY test.py .
RUN apt-get update && apt-get install -y vsftpd
COPY src/entrypoint.sh .
RUN ["chmod", "+x", "./entrypoint.sh"]
ENTRYPOINT [ "./entrypoint.sh" ]
EXPOSE 20/tcp 21/tcp 81/tcp 40000-40009/tcp 10090-10100/tcp