#!/bin/bash

# See Conda docs: <https://docs.conda.io/projects/conda/en/latest/user-guide/tasks/index.html>

# Download miniconda:
wget -O ~/Downloads/miniconda_installer.sh https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
sh ~/Downloads/miniconda_installer.sh

# After conda has been installed, ensure base environment isn't auto activated <https://github.com/conda/conda/issues/8211>:
conda config --set auto_activate_base false

########################################
# Create Conda environment:
########################################
conda create -n nn python=3.7 -y
conda install jupyter=1.0.0=py37_7 -n nn  -y
# n.b. CPU version of TensorFlow!
# n.b. TensorFlow's recommended install is via Docker image.
conda install tensorflow=2.0.0 -n nn -y
conda install matplotlib -n nn -y


########################################
# Misc:
########################################
# Download TensorFlow Docker image:
docker pull tensorflow/tensorflow:latest-py3-jupyter

# Create aliases:
echo "\nalias docker_tensorflow=\"docker run -u \$(id -u):\$(id -g) -it -p 8888:8888 tensorflow/tensorflow:latest-py3-jupyter\"" >> ~/.bash_aliases
cat ~/.bash_aliases
