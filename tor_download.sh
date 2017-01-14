#!/bin/bash

# N.b. don't run via sudo/root user

uid=$(id -un)
wget "https://www.torproject.org/dist/torbrowser/6.0.8/tor-browser-linux64-6.0.8_en-US.tar.xz" -O /home/$uid/Downloads/tor_browserx64.tar.xz
tar xf /home/$uid/Downloads/tor_browserx64.tar.xz
rm /home/$uid/Downloads/tor_browserx64.tar.xz
