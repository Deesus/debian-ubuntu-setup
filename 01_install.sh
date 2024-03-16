#!/bin/bash

# ########################################
# Installs machine learning and web development packages.
# After running the install script, you should run the post install script (`02_post_install.sh).
#
# Quick start: execute the file (DO NOT use sudo): `sh 01_install.sh`
# ########################################

# Prevent script from running as root:
if [ $(whoami) = "root" ]
then
    echo "\nDO NOT run this script with sudo!"
    echo "Exiting...\n"
    exit 1
fi

# Start of installation:
sudo apt update

# ########## Bug fixes: ##########
# Fixes AttributeError: 'NoneType' object has no attribute 'people'
# See <https://www.linuxquestions.org/questions/debian-26/debian-bullseye-sid-add-apt-repository-not-working-python-problem-4175720821/> and <https://askubuntu.com/questions/1480616/adding-opencpn-repository-attributeerror-nonetype-object-has-no-attribute>:
sudo apt get install python3-launchpadlib -yq

# ########## Replce pulseaudio with pipewire: ##########
# Pipewire is needed for screen sharing (e.g. OBS):
sudo apt purge pulseaudio pulseaudio-module-bluetooth -yq
sudo apt install pipewire pipewire-audio -yq
systemctl --user start pipewire

# ########## Setup Git: ##########
sudo apt install git -yq

git config --global init.defaultBranch master
# TODO: change `Deesus` to your user name:
git config --global user.name "Deesus"
# TODO: change `Deesus@users.noreply.github.com` to your email address:
git config --global user.email Deesus@users.noreply.github.com

# ########## Install useful packages: ##########
sudo apt install neovim -yq
sudo apt install curl -yq
sudo apt install nala -yq
sudo apt install neofetch -yq
sudo apt install kompare -yq  # File diffing library (e.g. for Dolphin)
sudo apt install scrcpy -yq  # Android screen capture lib. Remember to "Allow USB debugging" on your phone for scrcpy to work!
sudo apt install screen -yq
sudo apt install secure-delete -yq # secure-delete is better (more secure) than shred
sudo apt install keepassxc -yq  # Password manager
# yt-dlp <https://github.com/yt-dlp/yt-dlp>:
wget https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -O ~/.local/bin/yt-dlp
chmod a+rx ~/.local/bin/yt-dlp  # Make executable
cat <<EOT >> ~/.bashrc

# yt-dlp
export PATH=$PATH:~/.local/bin
# yt-dlp end
EOT

# ########## Install pnpm and Node.js: ##########
curl -fsSL https://get.pnpm.io/install.sh | sh -
source ~/.bashrc
pnpm env use --global lts


# ########## Install misc apps: ##########
# Install JetBrains Toolbox:
# TODO: this is a specific app version; you may need to occasionally update the file-path version (last updated 2024-03):
jetbrains_tarball="jetbrains-toolbox-2.2.2.20062.tar.gz"
downloaded_tarball=~/Downloads/$jetbrains_tarball
wget --content-disposition https://download.jetbrains.com/toolbox/$jetbrains_tarball -P ~/Downloads
# n.b. we need to specify output directory or else tar will extract to pwd:
tar -xzf $downloaded_tarball -C ~/Downloads
rm $downloaded_tarball
echo "\n\njetbrains-toolbox AppImage saved to ~/Downloads.\nPlease run the AppImage.\n\n"
sleep 2

# ########## Misc. ##########
# Create bash aliases file:
touch ~/.bash_aliases

# ########## Install Docker: ##########
sudo apt-get update
sudo apt-get install ca-certificates curl -yq
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -yq

# Run Docker without sudo:
# <https://docs.docker.com/engine/install/linux-postinstall>:
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker
docker run hello-world  # Verify that Docker has been installed correctly

# Configure Docker to start on boot:
# <https://docs.docker.com/engine/install/linux-postinstall>:
sudo systemctl enable docker.service
sudo systemctl enable containerd.service

# Install Docker Compose:
sudo apt-get update
sudo apt-get install docker-compose-plugin -yq
docker compose version  # Verify Docker Compose installation

# ########## Install Conda: ##########
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -P ~/Downloads/
# N.b. we use `bash` command and NOT `sh` (the latter throws errors):
# TODO: Follow the prompts. BE SURE TO SELECT "yes" ON WHETHER TO INITIALIZE CONDA ON STARTUP:
# If you fail to do so, you will have to add the conda path to .bashrc manually.
bash ~/Downloads/Miniconda3-latest-Linux-x86_64.sh

echo "\n\nRestart bash and run the '02_post_install.sh' script.\n"
