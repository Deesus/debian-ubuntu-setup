#!/bin/bash

# Some (opiniated) recommended packages for Debian/Ubuntu/Mint based distros.

# N.b. git is not preinstalled in some Debian/Ubuntu/Mint distros:
echo "Installing git...\n"
sudo apt install git -yq

# Install apt-get wrappers:
echo "Installing package managers...\n"
sudo apt-get install aptitude -y
sudo apt-get install synaptic -y

# Install Chromium browser:
sudo apt-get install chromium-browser -y

# Purge Flash plugin:
sudo apt-get purge flashplugin-installer -y
sudo apt-mark hold flashplugin-installer
VARIANTS="iceape iceweasel mozilla firefox xulrunner midbrowser xulrunner-addons"
sudo update-rc.d -f flashplugin-installer remove >/dev/null 2>&1
sudo rm -rf /usr/lib/flashplugin-installer-unpackdir
sudo rm -rf /usr/lib/flashplugin-installer/*
sudo rm -f /var/lib/flashplugin-installer/*
sudo rm -rf /var/cache/flashplugin-installer-unpackdir
sudo rm -rf /var/cache/flashplugin-installer
sudo rm -f /usr/share/ubufox/plugins/libflashplayer.so
sudo rm -f /usr/share/ubufox/plugins/npwrapper.libflashplayer.so
for x in $VARIANTS; do
sudo update-alternatives --quiet --remove "$x-flashplugin" /usr/lib/flashplugin-installer/libflashplayer.so;
done
for x in $VARIANTS; do
sudo update-alternatives --quiet --remove "$x-flashplugin" /var/lib/flashplugin-installer/npwrapper.libflashplayer.so;
done

# Install gparted:
sudo apt-get install gparted -yq
