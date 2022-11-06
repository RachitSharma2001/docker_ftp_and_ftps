from ftplib import FTP_TLS
import pytest 
import io
import os

content = "something else something else \n something\n"

USER = os.environ.get('USER')
PASS = os.environ.get('PASS')
HOST = os.environ.get('HOST')
PORT = int(os.environ.get('FTPS_PORT'))

@pytest.fixture
def ftps():
    ftps = FTP_TLS()
    ftps.connect(HOST, PORT)
    ftps.login(USER, PASS)
    ftps.prot_p()
    return ftps

def test_ftps_read_write(ftps):
    ftps.storlines("STOR ftps_file", io.BytesIO(content.encode('utf-8')))
    read_socket = ftps.transfercmd("RETR ftps_file")
    fobj = read_socket.makefile('r')
    assert fobj.read().replace('\r','') == content