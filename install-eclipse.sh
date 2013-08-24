#/bin/sh
#=======================================================================
# 2013
# You must install java to use eclipse! (apt-get install openjdk-7-jdk)
# Will download eclipse and extract it to /usr/local/eclipse.
# Will create a symbolic link in /usr/bin pointing to /usr/local/eclipse/eclipse
# Will create a .desktop file in /usr/share/applications/eclipse.desktop
#=======================================================================

tmp="$$.tar.gz"

cd /tmp

echo "== Downloading eclipse =="
wget -O $tmp "http://mirror.csclub.uwaterloo.ca/eclipse/technology/epp/downloads/release/kepler/R/eclipse-java-kepler-R-linux-gtk-x86_64.tar.gz"

echo "== Extracting eclipse =="
tar -xzf $tmp

echo "== Moving folder ==" 
mv eclipse /usr/local/eclipse

echo "== Creating link =="
ln -s /usr/local/eclipse/eclipse /usr/bin

echo "== Create .desktop file =="
echo "[Desktop Entry]
Name=Eclipse
Type=Application
Comment=Eclipse IDE
Version=4.3
Categories=Development;IDE;
Exec=eclipse
Icon=/usr/local/eclipse/icon.xpm
" > /usr/share/applications/eclipse.desktop

echo "== Cleaning up =="
rm $tmp
