#!/usr/bin/env python

"""
Makes JSON requests to the CGMiner API. This is compatible with
any fork of cgminer which has an API. It also requires that you
allow admin API access from the source machine using something like
"--allow-api W:127.0.0.1,192.168.1/24"
"""

import socket
import json
import sys
import errno
import time

"""
Reboot the system. User must have NOPASSWD sudo permissions
for /sbin/shutdown.
"""
def reboot():
	command = "/usr/bin/sudo /sbin/shutdown -r now"
	import subprocess
	process = subprocess.Popen(command.split(), stdout=subprocess.PIPE)
	output = process.communicate()[0]

"""
Call the API to tell it to restart the miner
"""
def restart():
	 send_api_request('restart')

"""
Make a request to the cgminer API. Supply a command as shown
in the cgminer API documentation.
"""
def send_api_request(command):
	try:
		sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
		sock.settimeout(15.0)
		sock.connect(('127.0.0.1', 4028))
	        sock.send(json.dumps({'command':command}))

	        resp = ''
	        while 1:
	                buf = sock.recv(4096)
        	        if buf:
                	        resp += buf
	                else:
        	                break

	        return resp
	except Exception, e:
		date = time.strftime("%c")
		print 'Connection to API failed at ' + date + ' with code [' + e.errno + ']. Rebooting system.'
		reboot()

"""
Send a single API request. There are no parameters currently, but
will probably be in a future revision.
"""
if __name__ == "__main__":
    try:
        print send_api_request(sys.argv[1])
    except Exception, e:
        date = time.strftime("%c")
        print "Exception occurred at " + date + ": \"" + e.message + "\""
        reboot()

