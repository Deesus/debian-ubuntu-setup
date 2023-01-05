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
git config --global init.defaultBranch master
sudo apt install neovim -yq
sudo apt install curl -yq
sudo apt install neofetch -yq
sudo apt install kompare -yq
sudo apt install scrcpy -yq # remember to "Allow USB debugging" on your phone in order for scrcpy to work!
sudo apt install keepassxc -yq
wget -O - https://raw.githubusercontent.com/laurent22/joplin/dev/Joplin_install_and_update.sh | bash

# ########## install pip and pipenv: ##########
sudo apt install python3-pip -yq
pip instsall --user pipenv
PYTHON_BIN_PATH="$(python3 -m site --user-base)/bin"
PATH="$PATH:$PYTHON_BIN_PATH"

# ########## Install non-Snap Chromium: ##########
# See <https://askubuntu.com/q/1386738>
sudo apt remove chromium-browser chromium-browser-l10n chromium-codecs-ffmpeg-extra -yq
echo "deb http://packages.linuxmint.com vanessa upstream" | sudo tee /etc/apt/sources.list.d/mint-vanessa.list
sudo apt-key adv --recv-keys --keyserver keyserver.ubuntu.com A1715D88E1DF1F24 40976EAF437D05B5 3B4FE6ACC0B21F32 A6616109451BBBF2

cat <<EOF | sudo tee /etc/apt/preferences.d/pin-chromium
Package: *
Pin: release o=linuxmint
Pin-Priority: -1

Package: chromium
Pin: release o=linuxmint
Pin-Priority: 1000
EOF

sudo apt update
sudo apt install chromium -yq

# ########## Install non-Snap Firefox: ##########
# See <https://askubuntu.com/a/1404401>
sudo snap remove --purge firefox
sudo add-apt-repository ppa:mozillateam/ppa

# Prioritize the apt version over Snap version of Firefox:
echo '
Package: *
Pin: release o=LP-PPA-mozillateam
Pin-Priority: 1001

Package: firefox
Pin: version 1:1snap1-0ubuntu2
Pin-Priority: -1
' | sudo tee /etc/apt/preferences.d/mozilla-firefox

sudo apt install firefox -yq

# Ensure that unattended upgrades do not reinstall the snap version of Firefox:
echo 'Unattended-Upgrade::Allowed-Origins:: "LP-PPA-mozillateam:${distro_codename}";' | sudo tee /etc/apt/apt.conf.d/51unattended-upgrades-firefox


# ########## Install misc apps: ##########
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
sudo apt-get install docker-ce docker-compose docker-ce-cli containerd.io -yq

# Enable Docker BuildKit by default <https://docs.docker.com/develop/develop-images/build_enhancements/>:
sudo bash -c 'cat << EOF >> /etc/docker/daemon.json
{
    "features": {
       "buildkit": true
    }
}
EOF'


echo "\n\nIMPORTANT: Remember to run the manual-install-script after installation!\n\n"
sleep 2
