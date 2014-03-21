#!/usr/bin/env python

import os, time, signal, errno

from datetime import datetime
from subprocess import call

class App():

    def __init__(self):
	self.time = 6*60*60
	self.logpath = '/var/log/snort/snortupdater.log'

    def run(self):
        dirpath = os.path.dirname(self.logpath)
        while True:
            time.sleep(self.time)
            if not os.path.exists(dirpath) or not os.path.isdir(dirpath):
                os.makedirs(dirpath)
            f = open(self.logpath, 'a+')
            f.write("%s: Running Update\n" % datetime.strftime(datetime.now(), '%Y-%m-%d %H:%M:%S'))
	    result = self.doupdate()
            f.write("%s: %s\n" % (datetime.strftime(datetime.now(), '%Y-%m-%d %H:%M:%S'), result))
            f.close()

    def doupdate(self):
	call("/root/apps/getrules.sh", shell=True)
	device = os.environ.get('DEVICE')
	if device != None:
	    if os.path.isfile("/var/run/snort_%s.pid" % device):
		pidf = open("/var/run/snort_%s.pid" % device, "r")
		pid = int(pidf.readline().rstrip())
		pidf.close()
		try:
		    os.kill(pid, signal.SIGHUP)
		except OSError, err:
		    if err.errno == errno.ESRCH:
			return "PID %d not running" % pid
		    elif error.errno == errno.EPERM:
			return "No permission to signal %d" % pid
		    else:
			return "Unknown error trying to signal %d" % pid
		return "Updated PID: %d" % pid
	    else:
		return "PID file /var/run/snort_%s.pid not found." % device
	else:
	    return "No device enviroment"

app = App()
print app.run()


