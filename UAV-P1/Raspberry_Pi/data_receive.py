import socket
import sys

sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
server = ("10.3.141.1",10000)

message = "Hi this is Python".encode()

sock.sendto(message,server)

while 1:
	try:
		data, adds = sock.recvfrom(4098)
		print (data.decode())
	except KeyboardInterrupt:
		break

print(["abs","abs"].join("/"))
