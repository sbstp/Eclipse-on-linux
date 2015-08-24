#!/bin/sh
#=======================================================================
# 2014 for eclipse Mars 4.5 (jdt)
# You must install java to use eclipse! (apt-get install openjdk-7-jdk)
# Will download eclipse and extract it to /usr/local/eclipse.
# Will create a symbolic link in /usr/bin pointing to /usr/local/eclipse/eclipse
# Will create a .desktop file in /usr/share/applications/eclipse.desktop
#=======================================================================

EclipseVersion="4.5";
JavaMinVer="1.7";
InstallPath="/usr/local/eclipse";

if [ "$(id -u)" != "0" ] ; then
   echo "This script must be run as root"
   exit 1
fi

if [ $# -gt 1 ] ; then
   echo "Usage: $0 [install_path]";
   echo "Default path is $InstallPath";
   exit 2;
elif [ $# -eq 1] ; then
   InstallPath=$1;
fi

echo "This script will download and install Eclipse $EclipseVersion on your computer in $InstallPath"
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

echo "Looking for installed jvms";
JavaOk=false;
Version=$(java -version 2>&1 | grep "java version"  | awk '{print $NF}' | sed s/\"//g);

if [ $(echo $Version | wc -l) -lt 1 ] ; then
    echo "No jvm was detected. Try \"sudo apt-get install openjdk-7-jdk\"";
fi

if [ $( echo $Version | grep "^$JavaMinVer" | wc -l) -eq "1" ] ; then
    JavaOk=true;
    echo "Detected java version was: $Version OK!";
else
    echo "Detected java version was: $Version"
    echo "Expected java $JavaMinVer ";
    valid=false;
    echo "What should we do ? [I]gnore or [C]ancel"
    while [ $valid != true ]
    do
        read choice
        case $choice in
            "c"|"C")
                echo "Exiting the script, nothing was changed on your computer !"
                exit 0
                ;;
            "i"|"I")
                valid=true
                ;;
            *)
                echo "Please make a valid selection : [I]gnore or [C]ancel";
                ;;
        esac
    done
fi

if [ -d $InstallPath ] ; then
    echo "Eclipse seems to be installed on this computer..."
    valid=false;
    echo "What should we do ? [O]verwrite, [C]ancel or [I]gnore"
    while [ $valid != true ]
    do
        read choice
        case $choice in
            "o"|"O")
                valid=true
                /bin/sh uninstall.sh
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

PrevDir=$PWD
cd /tmp

echo "== Downloading eclipse =="
wget -O $tmp "http://mirror.csclub.uwaterloo.ca/eclipse/technology/epp/downloads/release/mars/R/eclipse-java-mars-R-linux-gtk-x86_64.tar.gz"

echo "== Extracting eclipse =="
tar -xzf $tmp

echo "== Moving folder =="
mv eclipse $InstallPath

echo "== Creating link =="
ln -s $InstallPath/eclipse /usr/local/bin

echo "== Copying pretty icon =="
cp "$PrevDir/icon2.xpm" "$InstallPath/icon2.xpm"

echo "== Create .desktop file =="
echo "[Desktop Entry]
Name=Eclipse
Type=Application
Comment=Eclipse IDE
Version=$EclipseVersion
Categories=Development;IDE;
Exec=eclipse
Icon=$InstallPath/icon2.xpm
" > /usr/share/applications/eclipse.desktop

echo "== Copying uninstall script =="
cp "$PrevDir/uninstall.sh" "$InstallPath/uninstall.sh"

echo "== Cleaning up =="
rm $tmp

exit 0
