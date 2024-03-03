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

# Start of installation:
sudo apt update

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
sudo apt install scrcpy -yq  # Android screen capture library. Remember to "Allow USB debugging" on your phone in order for scrcpy to work!
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
# TODO: this is a specific app version; we may need to occasionally update the file-path version (last updated 2024-03):
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

# Install Conda:
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -P ~/Downloads/
# N.b. we use `bash` command and NOT `sh` (the latter throws errors):
bash ~/Downloads/Miniconda3-latest-Linux-x86_64.sh

# "Restart" bash without restarting terminal:
exec bash

# Ensure base environment isn't auto-activated <https://github.com/conda/conda/issues/8211>:
conda config --set auto_activate_base false && conda deactivate

# Replace default channel with conda-forge channel:
# N.b. we don't Want to have both default and conda-forge environments due to the extremely lengthy environment resolution time it takes <https://stackoverflow.com/a/66963979>
# Also, conda-forge is open source, while Anaconda packages are neither open source nor free for comercial use <https://www.anaconda.com/blog/anaconda-commercial-edition-faq>
conda config --add channels conda-forge
conda config --remove channels defaults
conda config --set channel_priority strict

# Install Mamba for fast package management <https://github.com/mamba-org/mamba>:
conda install mamba -n base -c conda-forge
mamba init

mamba create -n ml python=3.12 jupyterlab matplotlib pandas scikit-learn jupytext
# TODO: also (inside your conda environment), you might want to install Hugging Face (`mamba install transformers`) and/or spacy (via pip)
