sudo apt update

# ----- install useful packages: -----
sudo apt install git -yq
sudo apt install neovim -yq
sudo apt install curl -yq
sudo apt install neofetch -yq
sudo apt install kompare -yq
sudo snap install keepassxc -yq

# ----- install nvm and NodeJS: -----
# TODO: check if this is latest version of nvm before running script:
# TODO: this might not work without closing terminal and restarting:
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
export NVM_DIR="$HOME/.nvm" && \. "$NVM_DIR/nvm.sh"

nvm install --lts && nvm use --lts

# ----- install apps: -----
sudo apt install chromium-browser -yq

# ----- install Jetbrains IDEs: -----
sudo snap install pycharm-professional --classic -yq
sudo snap install webstorm --classic -yq

# ----- install Docker: -----
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

# ----- Docker-post install steps: -----
# <https://docs.docker.com/engine/install/linux-postinstall/>

# run Docker without root privileges -- n.b. this can be a security issue in some cases <https://docs.docker.com/engine/security/#docker-daemon-attack-surface>
sudo groupadd docker
sudo usermod -aG docker $(whoami)
exec bash
exit

# TODO: you may need to log out of your session and log back in before running this:
newgrp docker

echo "\nTesting that Docker was installed properly:\n"
docker run hello-world

# configure Docker to start on boot:
sudo systemctl enable docker.service
sudo systemctl enable containerd.service

# ----- install conda: -----
# download and install in one line <https://serverfault.com/a/226391>:
wget -O - https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh | bash
exec bash
exit

# after conda has been installed, ensure base environment isn't auto-activated <https://github.com/conda/conda/issues/8211>:
conda config --set auto_activate_base false

# create conda environment:
conda create -n nn python=3.8 tensorflow jupyter matplotlib

# ----- misc. -----
# these are commented out because they may not be necessary, but are good to have for reference

## Download TensorFlow Docker image:
# docker pull tensorflow/tensorflow:latest-py3-jupyter
# Create aliases:
# echo "\nalias docker_tensorflow=\"docker run -u \$(id -u):\$(id -g) -it -p 8888:8888 tensorflow/tensorflow:latest-py3-jupyter\"" >> ~/.bash_aliases
# cat ~/.bash_aliases

## pip3 and pipenv:
# sudo apt install python3-pip -yq
# pip install --user pipenv
# 
## reinstall due to this issue: <https://stackoverflow.com/q/51225750>
# sudo python3 -m pip uninstall pip && sudo apt install python3-pip --reinstall
