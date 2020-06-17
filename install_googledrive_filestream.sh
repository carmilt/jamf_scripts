#!/bin/bash


dmgfile="GoogleDriveFileStream.dmg"
pkgfile="GoogleDriveFileStream.pkg"
volname="Install Google Drive File Stream"
logfile="/tmp/google_filestream_script.log"
url='https://dl.google.com/drive-file-stream/GoogleDriveFileStream.dmg'


echo "--" >> ${logfile}
echo "`date`: Downloading latest version." >> ${logfile}
curl -L -s -o /tmp/${dmgfile} ${url}
echo "`date`: Mounting installer disk image." >> ${logfile}
hdiutil attach /tmp/${dmgfile} -nobrowse -quiet
echo "`date`: Installing..." >> ${logfile}
installer -pkg /Volumes/${volname}/${pkgfile} -target /
echo "`date`: Unmounting installer disk image." >> ${logfile}
hdiutil detach $(df | grep "${volname}" | awk '{print $1}') -quiet
echo "`date`: Deleting disk image." >> ${logfile}
rm /tmp/"${dmgfile}"

exit 0