#!/bin/bash

# ########################################
# All of these packages and fixes are OPTIONAL.
# Read the instructions and run only the commands that you need for your machine.
# ########################################

# To prevent execution of entire file:
echo "This script needs to be run manually -- i.e. follow the instructions in the file and run the commands line-by-line."
exit 1

# ########## Start here: ##########
# Update package repository if you haven't already:
sudo apt update

# ########## Install optional packages: ##########
# Python Pip3:
sudo apt install python3-pip -yq
# Reinstall due to this issue: <https://stackoverflow.com/q/51225750>
sudo python3 -m pip uninstall pip && sudo apt install python3-pip --reinstall

# Java Runtime Environment (JRE):
sudo apt install default-jre -yq

# Joplin notetaking app:
wget -O - https://raw.githubusercontent.com/laurent22/joplin/dev/Joplin_install_and_update.sh | bash

# ########## Install non-Snap Chromium (Ubuntu-based distros only): ##########
# See <https://askubuntu.com/q/1386738>
sudo apt remove chromium-browser chromium-browser-l10n chromium-codecs-ffmpeg-extra -yq
echo "deb http://packages.linuxmint.com vanessa upstream" | sudo tee /etc/apt/sources.list.d/mint-vanessa.list
sudo apt-key adv --recv-keys --keyserver keyserver.ubuntu.com A1715D88E1DF1F24 40976EAF437D05B5 3B4FE6ACC0B21F32 A6616109451BBBF2

cat <<EOF | sudo tee /etc/apt/preferences.d/pin-chromium
Package: *
Pin: release o=linuxmint
Pin-Priority: -1

Package: chromium
Pin: release o=linuxmint
Pin-Priority: 1000
EOF

sudo apt update
sudo apt install chromium -yq

# ########## Install non-Snap Firefox (Ubuntu-based distros only): ##########
# See <https://askubuntu.com/a/1404401>
sudo snap remove --purge firefox
sudo add-apt-repository ppa:mozillateam/ppa

# Prioritize the apt version over Snap version of Firefox:
echo '
Package: *
Pin: release o=LP-PPA-mozillateam
Pin-Priority: 1001

Package: firefox
Pin: version 1:1snap1-0ubuntu2
Pin-Priority: -1
' | sudo tee /etc/apt/preferences.d/mozilla-firefox

sudo apt install firefox -yq

# Ensure that unattended upgrades do not reinstall the snap version of Firefox:
echo 'Unattended-Upgrade::Allowed-Origins:: "LP-PPA-mozillateam:${distro_codename}";' | sudo tee /etc/apt/apt.conf.d/51unattended-upgrades-firefox

# ########## Purge ALL Snap packages (Ubuntu-based distros only): ##########
snap list
sudo snap remove EACH_SNAP_PACKAGE
sudo apt purge snapd
# Clean up by deleting this folder:
sudo rm -rf ~/snap
# There might be additional Snap folders, check if they exist, then delete:
sudo rm -rf /snap
sudo rm -rf /var/snap
sudo rm -rf /var/lib/snapd

# ########## Fix lag in bluetooth devices: ##########
# Autosuspend is a power saving feature, but causes Bluetooth mouse delay/lag if inactive for a few seconds.
# This section disables bluetooth autosuspend.

# Fix bug where bluetooth device lags when it has been idle for a few seconds:
# 1. Edit the grub file: `sudo nano /etc/default/grub`
# 2. Check for the line containing `GRUB_CMDLINE_LINUX_DEFAULT`
# 3. Append `btusb.enable_autosuspend=0` to the existing value. For example, if the field was previously `GRUB_CMDLINE_LINUX_DEFAULT="quiet"`
#    then change it to `GRUB_CMDLINE_LINUX_DEFAULT="quiet btusb.enable_autosuspend=0"`
# 4. Save and close the file.
# 5. Run `sudo update-grub`
# 6. Reboot your system.

# If the above method doesn't fix the issue, you may want to try running this command:
# `echo "options btusb enable_autosuspend=0" | sudo tee /etc/modprobe.d/disable_btusb-autosuspend.conf`
# And to undo this procedure, do `sudo rm /etc/modprobe.d/disable_btusb-autosuspend.conf`

# ########## (OPTIONAL) Associate magnet links with BitTorrent client: ##########
# 1. Locate your client/app in `/usr/share/applications/`
# 2. In the terminal enter `xdg-mime default DESKTOP_CONF_FILE x-scheme-handler/magnet` where DESKTOP_CONF_FILE is the name of the .desktop file in `/usr/share/applications/`
#    E.g. `xdg-mime default org.kde.ktorrent.desktop x-scheme-handler/magnet` for KTorrent or `xdg-mime default transmission-gtk.desktop x-scheme-handler/magnet` for Transmission.

# ########## Disable alert sounds in Gnome: ##########
# Reference: <https://askubuntu.com/q/1282170>
gsettings set org.gnome.desktop.sound event-sounds false

# ########## Disable the Google One Tap sign-up prompts: ##########
# To disable the Google One Tap sign-up prompts <https://superuser.com/q/1414410>,
# in uBlock Origin's "My Filters," add the following: `accounts.google.com/gsi/iframe/$subdocument`

# ########## Update system firmware: ##########
fwupdmgr update
