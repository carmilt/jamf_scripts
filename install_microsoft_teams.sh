#!/bin/bash


pkgfile="Teams_osx.pkg"
logfile="/tmp/microsoft_teams_install_script.log"
url='https://teams.microsoft.com/downloads/desktopurl?env=production&plat=osx&arch=&download=true'


echo "--" >> ${logfile}
echo "`date`: Downloading latest version." >> ${logfile}
curl -L -s -o /tmp/${pkgfile} ${url}
echo "`date`: Installing..." >> ${logfile}
installer -pkg /Volumes/tmp/${pkgfile} -target /
echo "`date`: Deleting installer files." >> ${logfile}
rm /tmp/"${pkgfile}"

exit 0
