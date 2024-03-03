#!/bin/bash

# ########################################
# Completes installing/setting up packages. N.b. you need to run `01_install.sh` before running this script.
#
# Quick start: execute the file (DO NOT use sudo): `sh 02_post_install.sh`
# ########################################

# Prevent script from running as root:
if [ $(whoami) = "root" ]
then
    echo "\nDO NOT run this script with sudo!"
    echo "Exiting...\n"
    exit 1
fi

# ########## Finish setting up Conda: ##########
# Ensure base environment isn't auto-activated <https://github.com/conda/conda/issues/8211>:
conda config --set auto_activate_base false && conda deactivate

# Replace default channel with conda-forge channel:
# N.b. we don't want to have both default and conda-forge environments due to the extremely lengthy environment
# resolution time it takes <https://stackoverflow.com/a/66963979>. Also, conda-forge is open source, while Anaconda
# packages are neither open source nor free for commercial use.
# <https://www.anaconda.com/blog/anaconda-commercial-edition-faq>
conda config --add channels conda-forge
conda config --remove channels defaults
conda config --set channel_priority strict

# Install Mamba for fast package management <https://github.com/mamba-org/mamba>:
conda install mamba -n base -c conda-forge
mamba init

# Create a new conda environment:
mamba create -n ml python=3.12 jupyterlab matplotlib pandas scikit-learn jupytext
# TODO: also (inside your conda environment), you might want to install Hugging Face (`mamba install transformers`) and/or spacy (via pip)
