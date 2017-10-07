#!/bin/bash

# N.b. For Ubunut-based OS only.
echo "Installing WineHQ...\nNote: this script is only for Ubuntu."

sudo dpkg --add-architecture i386
sudo add-apt-repository ppa:wine/wine-builds
sudo apt-get update
sudo apt-get install --install-recommends winehq-devel -yq

