#!/bin/bash

# Some (opiniated) packages for KDE Plasma 5 desktop:

# Add respositories:
sudo add-apt-repository ppa:lyzardking/ubuntu-make          # add Ubuntu Make

# VSCodium:
wget -qO - https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg | sudo apt-key add - 
echo 'deb https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/repos/debs/ vscodium main' | sudo tee --append /etc/apt/sources.list.d/vscodium.list 

# Docker CE (stable):
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

# Update packages:
sudo apt-get update


########################################
# Install packages:
########################################

# Add snap package manager:
sudo apt install snapd

# Install apt-get wrappers:
sudo apt-get install aptitude -yq

# Install xinput:
sudo apt-get install xinput -yq

# Install Chromium browser:
sudo apt-get install chromium-browser -yq

# Install VLC Player:
sudo apt-get install vlc -yq

# Install curl:
sudo apt-get install curl -yq

# Install Vim:
sudo apt-get install vim -yq

# Install KeePassX:
sudo apt-get install keepassx -yq


########################################
# Install DEV packages:
########################################

# N.b. git is not preinstalled in some Debian/Ubuntu/Mint distros:
sudo apt install git -yq

##### Install NodeJS and npm: #####
sudo apt-get purge nodejs -y # purge apt-get version
sudo snap install node --channel=12/stable --classic

sudo chown -R $(whoami) ~/.npm # give user permission to delete
sudo chown -R $(whoami) ~/.config # give user access to config

# Add Ubuntu Make:
sudo apt-get install ubuntu-make -yq

# Install Vue.js (from npm):
sudo npm install vue-cli -g --save-dev

##### Python: #####
# pip3 for Python 3:
sudo apt install python3-pip -y

# pipenv:
pip install --user pipenv

# reinstall due to this issue: <https://stackoverflow.com/questions/51225750/installation-of-pipenv-causes-pip3-unusable>
sudo python3 -m pip uninstall pip && sudo apt install python3-pip --reinstall

##### IDEs: #####
# Install VSCodium:
sudo apt install codium -y

##### Docker: #####
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common -y

sudo apt-get install docker-ce docker-ce-cli containerd.io

# Post-install steps <https://docs.docker.com/install/linux/linux-postinstall/>:
sudo groupadd docker
sudo usermod -aG docker $(whoami)


########################################
# Install Kvantum:
########################################

sudo apt-get install g++ libx11-dev libxext-dev qtbase5-dev libqt5svg5-dev libqt5x11extras5-dev libkf5windowsystem-dev qttools5-dev-tools cmake checkinstall -y

mkdir -p ~/TEMP/tsujan && cd ~/TEMP/tsujan
git clone https://github.com/tsujan/Kvantum.git && cd Kvantum
git checkout master

cd Kvantum
mkdir build && cd build
cmake ..
make

sudo make install

echo "export QT_STYLE_OVERRIDE=kvantum" >> ~/.profile

rm -r ~/TEMP


########################################
# Purge Flash plugin:
########################################

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


########################################
# Set tab spaces:
########################################

cat <<EOF >> ~/.vimrc

" Only do this part when compiled with support for autocommands.
if has("autocmd")
    " Use filetype detection and file-based automatic indenting.
    filetype plugin indent on

    " Use actual tab chars in Makefiles.
    autocmd FileType make set tabstop=8 shiftwidth=8 softtabstop=0 noexpandtab
endif

" For everything else, use a tab width of 4 space chars.
set tabstop=4       " The width of a TAB is set to 4.
                    " Still it is a \t. It is just that
                    " Vim will interpret it to be having
                    " a width of 4.
set shiftwidth=4    " Indents will have a width of 4.
set softtabstop=4   " Sets the number of columns for a TAB.
set expandtab       " Expand TABs to spaces.

EOF


########################################
# Misc.:
########################################

# Disable baloo_file_extractor:
sudo balooctl disable

# create bash aliases file:
touch ~/.bash_aliases


########################################
# Optional Packages:
########################################

# sudo add-apt-repository ppa:graphics-drivers/ppa            # add graphics drivers ppa
# sudo add-apt-repository ppa:kirillshkrogalev/ffmpeg-next    # add ffmpeg ppa
# sudo add-apt-repository ppa:obsproject/obs-studio           # add OBS ppa

# # Update packages:
# sudo apt-get update

# # Install qBittorrent:
# echo "/nInstalling qBittorrent..."
# sudo apt-get install qbittorrent -yq

# # Install OBS:
# echo "/nInstalling OBS..."
# sudo apt-get install ffmpeg -yq
# sudo apt-get install obs-studio -yq

# # Install lvm2:
# echo "\nInstalling lvm2..."
# # N.b. this also resolves booting issues with Linux kernel 4.8.0-34-generic (earlier kernel releases don't seem to have this issue):
# sudo apt-get install lvm2 -yq
