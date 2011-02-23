#!/usr/local/bin/python
#Anthony Scotti
#amscotti@128bitstudios.com
#Used to make snapshot of all the file systems on a zpool.
 
import commands
import subprocess
import time
import os
 
timestamp = time.strftime("%Y%m%d-%H%M")
 
zpoolName = "storage"
zfsList = commands.getoutput("zfs list -o name | grep %s/" % zpoolName)
 
for zfsFileSystems in zfsList.split("\n"):
        print "Snapshoting-> %s" % (zfsFileSystems)
        commands.getoutput("zfs snapshot %s@%s" % (zfsFileSystems, timestamp))