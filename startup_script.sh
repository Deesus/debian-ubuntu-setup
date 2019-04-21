#!/bin/bash
# Add this script to your distro's system startup -- in KDE, this can be done in the program "Autostart".


# Fixes ThinkPad's TrackPoint sensitivity:
# n.b. it looks for the device name "TPPS/2 IBM TrackPoint":
TRACKPOINTID="$(xinput list --id-only 'TPPS/2 IBM TrackPoint')"
xinput --set-prop "${TRACKPOINTID}" "libinput Accel Speed" -1.0
