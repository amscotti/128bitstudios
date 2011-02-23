#!/usr/local/bin/python
#Anthony Scotti
#amscotti@128bitstudios.com
#Used to remove old snapshots of all the file systems on a zpool.
 
import commands
import subprocess
import time
import datetime
 
now = datetime.datetime.now()
zpoolName = "storage"
 
zfsList = commands.getoutput("zfs list -H -t snapshot | awk '{print $1}' | grep %s/" % zpoolName)
 
for zfsSnapshot in zfsList.split("\n"):
        dateSnapshot = datetime.datetime.strptime(zfsSnapshot.split("@")[1], "%Y%m%d-%H%M")
        if (now - dateSnapshot) >= datetime.timedelta(days = 30):
                print "Removing-> %s" % (zfsSnapshot)
                commands.getoutput("zfs destroy %s" % (zfsSnapshot))
