from ftplib import FTP

ftp = FTP()
ftp.debugging = 2
ftp.connect('localhost', 81)
ftp.login('user', '123')
print("Done!")

print(ftp.pwd())
socket = ftp.transfercmd("STOR file_new")
fobj = socket.makefile('w')
fobj.write("asdfsdfdsf")
fobj.close()
socket.close()
print("Done again!")
print(ftp.mlsd())