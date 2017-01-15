#!/bin/bash

# Installs missing packages that are requisite for certain commercial VPN
#
# Known issues: DO NOT INSTALL if your machine is currently running KDE Plasma 5.
# N.b. Tested only on Ubuntu/Debian/Linux Mint systems.


Install_packages () {
    apt-get install libcurl3 -yq
    apt-get install libc-ares2 -yq

    # Update backport in order to install `libjsoncpp0`:
    echo "deb http://cz.archive.ubuntu.com/ubuntu trusty main universe" >> /etc/apt/sources.list
    apt-get update
    apt-get install libjsoncpp0 -yq
    echo "\nNOTE: /etc/apt/sources.list was modified to include mirrors that contain untrusted packages!"
    echo "You may want to remove this line from your sources: deb http://cz.archive.ubuntu.com/ubuntu trusty main universe"
}

echo "WARNING: this script is known to break when KDE Plasma 5 is installed (i.e. you will not be able to boot).\nIt is recommended that you DO NOT run this script if you have KDE Plasma 5.\n"

# Read input:
read -p "Do you wish to continue (y/n)? " USER_INPUT

# Convert to lowercase:
USER_INPUT=`echo $USER_INPUT | tr "[:upper:]" "[:lower:]"`

# Select:
case $USER_INPUT in
    yes|y )
        Install_packages
    ;;
    * )
        exit;
    ;;
esac
