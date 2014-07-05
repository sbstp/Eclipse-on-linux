#!/bin/bash
# This is an alternative version of the original script.
# Instead of downloading it for you, it simply extracts eclipse
# and properly configures it. This lets you use another archive,
# or use another mirror.
#

help() {
  echo "Usage: liteinstall Archive [Folder]"
  echo "Archive should be the Eclipse tar.gz."
  echo "Folder should be the directory where eclipse will be put in."
  echo "    Default is /usr/local/"
}

# Test if archive was given.
if [ "$#" -eq 0 ] ; then
  help
  exit
fi

archive="$1"
folder="/usr/local/"

# Test if folder was given.
if [ "$#" -gt 1 ] ; then
  folder="$2"
fi

echo "Decompressing archive ..."
tar -xzf "$archive"

echo "Moving eclipse to $folder/eclipse/ ..."
mv eclipse "$folder"

echo "Copying icon..."
cp icon2.xpm "$folder/icon2.xpm"

echo "Creating .desktop entry ..."
echo "[Desktop Entry]
Name=Eclipse
Type=Application
Comment=Eclipse IDE
Version=4.4
Categories=Development;IDE;
Exec=eclipse
Icon=$folder/icon2.xpm
" > "/usr/share/applications/eclipse.desktop"

echo "Create link ..."
ln -s "$folder/eclipse/eclipse" "/usr/local/bin/eclipse"

echo "Copying uninstall script ..."
cp uninstall.sh "$folder/eclipse/uninstall.sh"

echo "Done!"
