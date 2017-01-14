#!/bin/bash

# -----------------------------------------------------------
# Install latest version of Firefox:
# assuming you have downloaded the tar file from Firefox, move the folder to /opt/firefox

# Change permissions/ownership:
uid=$(id -un)
sudo chown :users /opt/firefox
sudo chmod -R a+rwx /opt/firefox

# Create desktop icon:
touch /usr/share/applications/firefox.desktop
echo "[Desktop Entry]
Encoding=UTF-8
Name=Mozilla Firefox
Comment=Browse the World Wide Web
Type=Application
Terminal=false
Exec=/usr/bin/firefox %U
Icon=/opt/firefox/icons/mozicon128.png
StartupNotify=true
Categories=Network;WebBrowser;" >> /usr/share/applications/firefox.desktop

# Remove Iceweasel:
sudo apt-get purge iceweasel

# -----------------------------------------------------------
# Install Synaptics touchpad drivers for KDE (Jesse):
echo -e "\ndeb http://ftp.us.debian.org/debian jessie main" >> /etc/apt/sources.list
sudo apt-get update# -----------------------------------------------------------
sudo apt-get install kde-config-touchpad
