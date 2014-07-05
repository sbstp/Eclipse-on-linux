#!/bin/bash
#=======================================================================
# 2013
# Remove the eclipse you installed with the other script.
# Will remove /usr/local/eclipse
# Will remove /usr/bin/eclipse if a link
# Will remove /usr/share/applications/eclipse.desktop
#=======================================================================

InstallPath="/usr/local/eclipse";

if [ "$(id -u)" != "0" ] ; then
   echo "This script must be run as root"
   exit 1
fi

if [ $# -gt 1 ] ; then
   echo "Usage: $0 [install_path]";
   echo "Default path is $InstallPath";
   exit 2;
elif [ $# -eq 1 ] ; then
   InstallPath=$1;
fi

if [ -d $InstallPath ] ; then
    echo "== Removing eclipse install folder =="
    rm -r $InstallPath
fi

if [ -h /usr/local/bin/eclipse ] ; then
    echo "== Removing link in /usr/local/bin =="
    rm /usr/local/bin/eclipse
fi

if [ -e /usr/share/applications/eclipse.desktop ] ; then
    echo "== Removing .desktop icon =="
    rm -r /usr/share/applications/eclipse.desktop
fi
