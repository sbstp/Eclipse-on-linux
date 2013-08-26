#!/bin/sh
#=======================================================================
# 2013 for eclipse kepler 4.3 (jdt)
# You must install java to use eclipse! (apt-get install openjdk-7-jdk)
# Will download eclipse and extract it to /usr/local/eclipse.
# Will create a symbolic link in /usr/bin pointing to /usr/local/eclipse/eclipse
# Will create a .desktop file in /usr/share/applications/eclipse.desktop
#=======================================================================

EclipseVersion="4.3";

if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root"
   exit 1
fi

echo "This script will download and install Eclipse $EclipseVersion on your computer"
echo "Are you sure you want to continue ? [Y]es [N]o"
valid=false;
while [ $valid != true ]
do
    read choice
    case $choice in
        "Y"|"y")
            valid=true;
            ;;
        "N"|"n")
            echo "Exiting the script, nothing was changed on your computer !"
            exit 0;
            ;;
        *)
            echo "Please make a valid selection : [Y]es [N]o";
            ;;
        esac
done



if [ -d /usr/local/eclipse ] ; then
    echo "Eclipse seems to be installed on this computer..."
    valid=false;
    echo "What should we do ? [O]verwrite, [C]ancel or [I]gnore"
    while [ $valid != true ]
    do
        read choice
        case $choice in
            "o"|"O")
                valid=true
                /bin/sh uninstall-eclipse.sh
                ;;
            "c"|"C")
                echo "Exiting the script, nothing was changed on your computer !"
                exit 0
                ;;
            "i"|"I")
                valid=true
                ;;
            *)
                echo "Please make a valid selection : [O]verwrite, [C]ancel or [I]gnore";
                ;;
        esac
    done
fi

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
