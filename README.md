# Environment Setup for KDE Plasma 5/Kubuntu

Supplemental packages and fixes for my KDE Desktop setup.
N.b. specific to x64 architecture and Plasma 5.

### Quick Start:
1. Run the `Kubuntu_DE_install.sh` scripts to install packages.
2. Add the `startup_script` to the distro's startup programs and scripts (e.g. 'Autostart').

## Installs:
* Arc Dark Theme (plus icons) for KDE
* Package managers:
    - aptitude 
    - synaptic
* Applications:
    - qBittorrent
    - Chromium
    - Vim
    - OBS (Open Broadcaster Software)
    - VLC Player
* Utilities:
    - git
    - curl
    - lvm2 (logical volume manager)
    - xinput (configure and test X input devices)

## Fixes:
* purges Flash plugin
* disables baloo_file_extractor
* replaces [PIA](https://www.privateinternetaccess.com/) tray icons
* adjusts ThinkPad's TrackPoint sensitivity

## TODO:
+ [ ] Include patch to remove kwallet from OS.

## License:
Copyright © 2017-2019 Dee Reddy. BSD-2 License.
