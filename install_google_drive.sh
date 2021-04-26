#!/bin/bash


dmgfile="GoogleDrive.dmg"
pkgfile="GoogleDrive.pkg"
volname="Install Google Drive"
logfile="/tmp/google_drive_script.log"
url='https://dl.google.com/drive-file-stream/GoogleDrive.dmg'


echo "--" >> ${logfile}
echo "`date`: Downloading latest version." >> ${logfile}
curl -s -o /tmp/${dmgfile} ${url}
echo "`date`: Mounting installer disk image." >> ${logfile}
hdiutil attach /tmp/${dmgfile} -nobrowse -quiet
echo "`date`: Installing..." >> ${logfile}
installer -pkg /Volumes/"${volname}"/${pkgfile} -target /
echo "`date`: Unmounting installer disk image." >> ${logfile}
hdiutil detach $(df | grep "${volname}" | awk '{print $1}') -quiet
echo "`date`: Deleting disk image." >> ${logfile}
rm /tmp/"${dmgfile}"

exit 0
