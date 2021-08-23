!/bin/bash

# ########################################
# Installs machine learning and web development packages.
# After running the install script, you might want to install the "interactive" packages (also included in this repo).
# 
# Quick start: simply run the file as root: `sudo sh install_packages.sh`
# ########################################

sudo apt update

# ########## install useful packages: ##########
sudo apt install git -yq
sudo apt install neovim -yq
sudo apt install curl -yq
sudo apt install neofetch -yq
sudo apt install kompare -yq
sudo snap install keepassxc

# ########## install apps: ##########
sudo apt install chromium-browser -yq

# ########## install Jetbrains IDEs: ##########
sudo snap install pycharm-professional --classic
sudo snap install webstorm --classic

# ########## misc. ##########
# create bash aliases file:
touch ~/.bash_aliases

# ########## install Docker: ##########
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  
sudo apt update
sudo apt-get install docker-ce docker-ce-cli containerd.io -yq

echo "\n\nIMPORTANT: Remember to run the manual-install-script after installation!\n\n"
sleep 2
