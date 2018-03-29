#!/bin/bash
# Install Nvidia drivers:
# n.b. the version of your package depends on your OS and card (don't use .run files)
# see https://help.ubuntu.com/community/BinaryDriverHowto/Nvidia
echo "/nInstalling Nvidia 375 drivers..."
echo "/nNote: The specific package you need will depend on your OS and your card."
sudo apt-get install nvidia-375 nvidia-settings
