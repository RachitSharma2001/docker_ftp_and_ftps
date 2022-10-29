from ftplib import FTP
import pytest 
import io

content = "something else something else \n something\n"

@pytest.fixture
def ftp():
    ftp = FTP()
    ftp.connect('localhost', 81)
    ftp.login('user', '123')
    return ftp

def test_ftp_read_write(ftp):
    ftp.storlines("STOR ftp_file", io.BytesIO(content.encode()))
    read_socket = ftp.transfercmd("RETR ftp_file")
    fobj = read_socket.makefile('r')
    assert fobj.read() == content 
