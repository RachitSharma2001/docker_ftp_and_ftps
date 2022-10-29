from ftplib import FTP_TLS
import pytest 
import io

content = "something else something else \n something\n"

@pytest.fixture
def ftps():
    ftps = FTP_TLS()
    ftps.connect('localhost', 21)
    ftps.login('user', '123')
    ftps.prot_p()
    return ftps

def test_ftps_read_write(ftps):
    ftps.storlines("STOR ftps_file", io.BytesIO(content.encode('utf-8')))
    read_socket = ftps.transfercmd("RETR ftps_file")
    fobj = read_socket.makefile('r')
    assert fobj.read().replace('\r','') == content