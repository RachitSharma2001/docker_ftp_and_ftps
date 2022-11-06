from ftplib import FTP
import pytest 
import io
import os

content = "something else something else \n something\n"

USER = os.environ.get('USER')
PASS = os.environ.get('PASS')
HOST = os.environ.get('HOST')
PORT = int(os.environ.get('FTP_PORT'))

@pytest.fixture
def ftp():
    ftp = FTP()
    ftp.connect(HOST, PORT)
    ftp.login(USER, PASS)
    return ftp

def test_ftp_read_write(ftp):
    ftp.storlines("STOR ftp_file", io.BytesIO(content.encode()))
    read_socket = ftp.transfercmd("RETR ftp_file")
    fobj = read_socket.makefile('r')
    assert fobj.read() == content 
