#!/bin/bash


# static configuration parameters
server=""
share=""
username=""
password=""
# NOTE: password must not contain spaces or special chars (@,!,#.$,etc.)

# retrieve the MAC address of the wired Ethernet adapter
mac=`ifconfig en0 | grep ether | awk '{print $2}' | sed 's/://g'`

# create a directory to mount the share at
if ! [ -d /Users/Shared/mnt ]; then
	mkdir -p /Users/Shared/mnt						
fi

# mount the SMB share
mount -t smbfs "//$username:$password@$server/$share" "/Users/Shared/mnt"

# Verify the share was mounted successfully
if ! [ -d /Users/Shared/mnt/Deploy ]; then
	logger -t set_computername.sh "Share not mounted, aborting."; exit 1						
fi

# copy mac address file
cp "/Users/Shared/mnt/$mac/$mac.txt" "/Users/Shared/"

# retrieve Machinename from MAC address file
machinename=`grep 'Computername' /Users/Shared/$mac.txt | awk '{print $2}'`

# Preferences are case sensitive
# Set Machinename
scutil --set HostName $machinename
scutil --set LocalHostName $machinename
scutil --set ComputerName $machinename

# unmount the share
#diskutil unmount /Users/Shared/mnt
umount /Users/Shared/mnt

# Clean up files and directories
rm -rf /Users/Shared/$mac.txt
rmdir /Users/Shared/mnt

logger -t set_computername.sh "Completed successfully."; exit 0