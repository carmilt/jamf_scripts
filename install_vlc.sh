#!/bin/bash


dmgfile="vlc.dmg"
volname='VLC media player'
appname="VLC.app"
logfile="/tmp/vlc_install_script.log"
url='https://get.videolan.org/vlc/3.0.10/macosx/vlc-3.0.10.dmg'


echo "--" >> ${logfile}
echo "`date`: Downloading latest version." >> ${logfile}
curl -L -s -o /tmp/${dmgfile} ${url}
echo "`date`: Mounting installer disk image." >> ${logfile}
hdiutil attach /tmp/${dmgfile} -nobrowse -quiet
echo "`date`: Installing..." >> ${logfile}
ditto -rsrc /Volumes/"${volname}"/${appname} /Applications/${appname}
echo "`date`: Unmounting installer disk image." >> ${logfile}
hdiutil detach $(df | grep "${volname}" | awk '{print $1}') -quiet
echo "`date`: Deleting disk image." >> ${logfile}
rm /tmp/"${dmgfile}"

exit 0