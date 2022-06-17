#!/bin/bash

# Sets up AWS CLI

echo "Setting up AWS CLI.."
cd ~/Downloads
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
/usr/local/bin/aws --version
# TODO: do we want to delete the download files after install?

echo "--------------------"
echo "See 'https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-quickstart.html#cli-configure-quickstart-config' for AWS configuration"
echo "--------------------"
aws configure

