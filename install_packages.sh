#!/bin/bash

# ########################################
# Installs machine learning and web development packages.
# After running the install script, you might want to install the "interactive" packages (also included in this repo).
# 
# Quick start: execute the file (DO NOT use sudo): `sh install_packages.sh`
# ########################################

# prevent script from running as root:
if [ $(whoami) = "root" ]
then
    echo "\nDO NOT run this script with sudo!"
    echo "Exiting...\n"
    exit 1
fi

# start of installation:
sudo apt update

# ########## install useful packages: ##########
sudo apt install git -yq
sudo apt install neovim -yq
sudo apt install curl -yq
sudo apt install neofetch -yq
sudo apt install kompare -yq
sudo snap install keepassxc
wget -O - https://raw.githubusercontent.com/laurent22/joplin/dev/Joplin_install_and_update.sh | bash

# ########## install apps: ##########
sudo apt install chromium-browser -yq

# install JetBrains Toolbox:
# TODO: this is a specific app version; we may need to occasionally update the file-path version (last updated 2021-08):
jetbrains_tarball="jetbrains-toolbox-1.21.9712.tar.gz"
downloaded_tarball=/home/$(whoami)/Downloads/$jetbrains_tarball
wget --content-disposition https://download.jetbrains.com/toolbox/$jetbrains_tarball -P /home/$(whoami)/Downloads
# n.b. we need to specify output directory or else tar will extract to pwd:
tar -xf $downloaded_tarball -C /home/$(whoami)/Downloads
rm $downloaded_tarball
echo "\n\njetbrains-toolbox AppImage saved to ~/Downloads.\nPlease run the AppImage.\n\n"
sleep 2

# ########## misc. ##########
# create bash aliases file:
touch ~/.bash_aliases

# ########## install Docker: ##########
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release -yq

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  
sudo apt update
sudo apt-get install docker-ce docker-ce-cli containerd.io -yq

echo "\n\nIMPORTANT: Remember to run the manual-install-script after installation!\n\n"
sleep 2
