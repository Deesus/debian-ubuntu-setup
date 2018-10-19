#!/bin/bash

# Some (opiniated) packages for Kubuntu Plasma 5 desktop:

# Add respositories:
sudo add-apt-repository ppa:papirus/papirus                 # Arc KDE Theme
sudo add-apt-repository ppa:graphics-drivers/ppa            # add graphics drivers ppa
sudo add-apt-repository ppa:kirillshkrogalev/ffmpeg-next    # add ffmpeg ppa
sudo add-apt-repository ppa:obsproject/obs-studio           # add OBS ppa

# Update packages:
sudo apt-get update


########################################
# Install packages:
########################################

# Add snap package manager:
echo "\nInstalling snap package manager..."
sudo apt install snapd

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

# Install VLC Player:
echo "/nInstalling VLC Player..."
sudo apt-get install vlc -yq

# Install qBittorrent:
echo "/nInstalling qBittorrent..."
sudo apt-get install qbittorrent -yq

# Install OBS:
echo "/nInstalling OBS..."
sudo apt-get install ffmpeg -yq
sudo apt-get install obs-studio -yq

# Install curl:
echo "/nInstalling curl..."
sudo apt-get install curl -yq

# Install Vim:
echo "/nInstalling Vim.."
sudo apt-get install vim -yq

# Install KeePassX:
echo "/nInstallling KeePassX..."
sudo apt-get install keepassx -yq


########################################
# Purge Flash plugin:
########################################

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
# Install PIA (Private Internet Access VPN) tray icons:
########################################

PIA_DIRECTORY=/opt/pia/frontend/img

# check if directory exists:
if [ -d "$PIA_DIRECTORY" ]; then 
    # ignore symlinks:
    if [ ! -L "$PIA_DIRECTORY" ]; then
        # directory found
        
        # backup icons:
        echo "Found PIA (VPN)"
        echo "backing up icons in the '$PIA_DIRECTORYoriginal_icons' folder..."
        sudo mkdir $PIA_DIRECTORY/original_icons
        sudo mv $PIA_DIRECTORY/tray_connected.png $PIA_DIRECTORY/original_icons/
        sudo mv $PIA_DIRECTORY/tray_connecting.png $PIA_DIRECTORY/original_icons/
        sudo mv $PIA_DIRECTORY/tray_disconnected.png $PIA_DIRECTORY/original_icons/
        
        # copy new icons into folder:
        sudo cp ./icons/pia/tray_connected.png $PIA_DIRECTORY/tray_connected.png
        sudo cp ./icons/pia/tray_connecting.png $PIA_DIRECTORY/tray_connecting.png
        sudo cp ./icons/pia/tray_disconnected.png $PIA_DIRECTORY/tray_disconnected.png
        
    fi
fi


########################################
# Install Arc Dark Theme for KDE Plasma 5:
########################################

# N.b. installing Arc Dark Theme should always be last in script, since the user needs to read the console message after installing

# Also installs Papirus icon theme for consitent look
# <https://github.com/PapirusDevelopmentTeam/arc-kde>
# <https://github.com/PapirusDevelopmentTeam/papirus-icon-theme>
echo "\nInstalling Arc Dark Theme for KDE..."
sudo apt-get install --install-recommends arc-kde
sudo apt-get install papirus-icon-theme


echo "\n A few more steps are needed before you DE is updated to Arc Dark."
echo "\n1. Go to Icons and select Papirus-Dark."
echo "\n2. Go to Settings > Color and choose Arc Dark."
echo "\n3. Run Kvantum manager and select ArcDark theme."
echo "\n4. Go to Desktop Theme and change to Arc Dark."
echo "\n5. You should also change the desktop wallpaper."
echo "\nYou might need hardcode-fixer: https://github.com/Foggalong/hardcode-fixer"


########################################
# Misc.:
########################################

# Disable baloo_file_extractor:
echo "\nDisabling baloo_file_extractor..."
sudo balooctl disable
