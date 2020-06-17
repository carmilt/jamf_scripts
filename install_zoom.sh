#!/bin/bash


pkgfile="ZoomInstallerIT.pkg"
logfile="/tmp/zoom_script.log"
url='https://zoom.us/client/latest/ZoomInstallerIT.pkg'


echo "--" >> ${logfile}
echo "`date`: Downloading latest version." >> ${logfile}
curl -L -s -o /tmp/${pkgfile} ${url}
echo "`date`: Installing..." >> ${logfile}
installer -pkg /tmp/${pkgfile} -target /
echo "`date`: Deleting installer file." >> ${logfile}
rm /tmp/"${pkgfile}"

exit 0