#!/bin/bash

# Some (opiniated) recommended packages for Debian/Ubuntu/Mint based distros.

# Add graphics drivers ppa:
sudo add-apt-repository ppa:graphics-drivers/ppa

# Update packages:
sudo apt-get update

# N.b. git is not preinstalled in some Debian/Ubuntu/Mint distros:
echo "\nInstalling Git..."
sudo apt install git -yq

# Install apt-get wrappers:
echo "\nInstalling package managers..."
sudo apt-get install aptitude -yq
sudo apt-get install synaptic -yq

# Install lvm2:
echo "\nInstalling lvm2..."
# N.b. this also resolves booting issues with Linux kernel 4.8.0-34-generic (earlier kernel releases don't seem to have this issue):
sudo apt-get install lvm2 -yq

# Install xinput:
echo "\nInstalling xinput..."
sudo apt-get install xinput -yq

# Install Chromium browser:
echo "\nInstalling Chromium..."
sudo apt-get install chromium-browser -yq

# Purge Flash plugin:
echo "\nPurging Flash plugin..."
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
echo "/nInstalling gparted..."
sudo apt-get install gparted -yq

# Install VLC Player:
echo "/nInstalling VLC Player..."
sudo apt-get install vlc -yq

# Install qBittorrent:
echo "/nInstalling qBittorrent..."
sudo apt-get install qbittorrent -yq

# Install curl:
echo "/nInstalling curl..."
sudo apt-get install curl -yq

# Install vim:
echo "/nInstalling vim.."
sudo apt-get install vim -yq

# set tab spaces:
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

