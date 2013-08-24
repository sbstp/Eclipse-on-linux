#/bin/sh
#=======================================================================
# 2013
# Remove the eclipse you installed with the other script.
# Will remove /usr/local/eclipse
# Will remove /usr/bin/eclipse if a link
# Will remove /usr/share/applications/eclipse.desktop
#=======================================================================

if [ -d /usr/local/eclipse ] ; then
	echo "== Removing eclipse install folder =="
	rm -r /usr/local/eclipse
fi

if [ -h /usr/bin/eclipse ] ; then
	echo "== Removing link in /usr/bin =="
	rm /usr/bin/eclipse
fi

if [ -e /usr/share/applications/eclipse.desktop ] ; then
	echo "== Removing .desktop icon =="
	rm -r /usr/share/applications/eclipse.desktop
fi
