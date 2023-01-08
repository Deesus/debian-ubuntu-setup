#!/bin/bash

# ########################################
# Instructions/commands for installing setting up certain packages and configurations.
# 
# Please follow the instructions and install each package in the terminal.
# Because this script install interactive packages, it cannot be run entirely via a single command.
# 
# N.b. you should first run the `install_packages.sh` file, as that script installs certain dependencies used here.
# ########################################

# to prevent execution of entire file:
echo "This script needs to be run manually -- i.e. follow the instructions in the file and run the commands line-by-line."
exit 1

# ########## start here: ##########
# update package repository if you haven't already:
sudo apt update


# ########## Purge ALL Snap packages: ##########
# TODO: To completely remove Snap packages, follow these steps:
# snap list
# sudo snap remove EACH_SNAP_PACKAGE
# sudo apt purge snapd

# TODO: next, you'll want clean up by deleting this folder:
# sudo rm -rf ~/snap

# TODO: There might be additional Snap folders, check if they exist, then delete:
# sudo rm -rf /snap
# sudo rm -rf /var/snap
# sudo rm -rf /var/lib/snapd

# ########## install Conda: ##########
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -P ~/Downloads/
# N.b. we use `bash` command and NOT `sh` (the latter throws errors):
bash ~/Downloads/Miniconda3-latest-Linux-x86_64.sh

# TODO: follow the instructions in the Conda interactive installation
# TODO: after installing minconda, restart your terminal before continuing:

# ensure base environment isn't auto-activated <https://github.com/conda/conda/issues/8211>:
conda config --set auto_activate_base false && conda deactivate

# install Mambda for fast package management <https://github.com/mamba-org/mamba>:
conda install mamba -n base -c conda-forge

# # replace default channel with conda-forge channel:
# # n.b. we don't want to have both default and conda-forge environments due to the extremely lengthy environment resolution time it takes <https://stackoverflow.com/a/66963979>
# # also, conda-forge is open source, while Anaconda packages are neither open source nor free for comercial use <https://www.anaconda.com/blog/anaconda-commercial-edition-faq>
conda config --add channels conda-forge
conda config --remove channels defaults
conda config --set channel_priority strict

# create a conda environment called "ml" (machine learning):
mamba create -n ml python=3.10 tensorflow jupyterlab matplotlib pandas scikit-learn
# TODO: after activing Conda environment, should install spacy via pip
# TODO: also install Hugging Face (inside conda environment): `mamba install transformers`

# ########## Docker-post install steps: ##########
# <https://docs.docker.com/engine/install/linux-postinstall/>

# run Docker without root privileges -- n.b. this can be a security issue in some cases <https://docs.docker.com/engine/security/#docker-daemon-attack-surface>
sudo groupadd docker
sudo usermod -aG docker $(whoami)

# TODO: log out of your session and log back in before continuing with the next steps:
newgrp docker

# test that Docker was installed properly:
docker run hello-world

# configure Docker to start on boot:
sudo systemctl enable docker.service
sudo systemctl enable containerd.service


# ########## install nvm and NodeJS: ##########
# TODO: you might want to check if this is latest version of nvm before running script <https://github.com/nvm-sh/nvm/releases>:
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.2/install.sh | bash

# TODO: after installation is done, restart terminal before continuing:
nvm install --lts && nvm use --lts


# ########## misc. ##########
# N.b. the rest of this script includes optional/alternatives packages that may be useful in certain cases

# ########## (OPTIONAL) Associate magnet links with BitTorrent client: ##########
# 1. Locate your client/app in `/usr/share/applications/`
# 2. In the terminal enter `xdg-mime default DESKTOP_CONF_FILE x-scheme-handler/magnet` where DESKTOP_CONF_FILE is the name of the .desktop file in `/usr/share/applications/`
#    E.g. `xdg-mime default org.kde.ktorrent.desktop x-scheme-handler/magnet` for KTorrent or `xdg-mime default transmission-gtk.desktop x-scheme-handler/magnet` for Transmission.

# ########## (OPTIONAL) download TensorFlow Docker image: ##########
# The Docker version of TensorFlow enables GPU. On the other hand, the "normal" conda installation runs TensorFlow on CPU.
docker pull tensorflow/tensorflow:latest-py3-jupyter
# create aliases:
echo "\nalias docker_tensorflow=\"docker run -u \$(id -u):\$(id -g) -it -p 8888:8888 tensorflow/tensorflow:latest-py3-jupyter\"" >> ~/.bash_aliases

# ########## (OPTIONAL) install pip and pipenv: ##########
sudo apt install python3-pip -yq
pip install --user pipenv

# reinstall due to this issue: <https://stackoverflow.com/q/51225750>
sudo python3 -m pip uninstall pip && sudo apt install python3-pip --reinstall


# ########## (OPTIONAL) disable alert sounds in Gnome: ##########
# refernce: <https://askubuntu.com/q/1282170>
gsettings set org.gnome.desktop.sound event-sounds false

