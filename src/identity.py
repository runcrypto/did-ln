#!/usr/bin/env python3

#
# identity.py
#
# Using lighning to save state for DID's
#
import socket
import sys
from time import sleep

# 0. Connect to the lightning-rpc socket

socket_location = '/home/clightning/.lightning/lightning-rpc'

sock = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
try:
	print("Connectng to {}".format(socket_location))
	sock.connect(socket_location)
	print("Connected")
except socket.error as msg:
	print("Could not connect to socket: {}".format(msg))
	sys.exit(1)

# 1. Given 2 node URL's establish coonnections to them
rpc_listpeers = '{"jsonrpc":"2.0", "method": "listpeers", "id": "identity", "params": []}'
print("send:{}".format(rpc_listpeers))
sock.send(rpc_listpeers.encode('UTF-8'))
response = sock.recv(100)
print("Response: {}".format(response))
sock.close()

# 2. Given a channel Id, identify if the channel exists between the 2 nodes


