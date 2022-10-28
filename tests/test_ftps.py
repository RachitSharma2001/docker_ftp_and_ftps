from ftplib import FTP_TLS

ftp = FTP_TLS()
ftp.debugging = 2
ftp.connect('localhost', 21)
ftp.login('user', '123')
ftp.prot_p()
print("Done!")


socket = ftp.transfercmd("STOR file")
fobj = socket.makefile('w')
fobj.write("asdfsdfdsf")
fobj.close()
socket.close()
print("Done again!")

print(ftp.mlsd())