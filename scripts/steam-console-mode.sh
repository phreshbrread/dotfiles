#! /bin/bash

killall steam steamwebhelper

gamescope -O DP-1 --display-index 0 -e -f -C --adaptive-sync -h 1440 -H 1080 -r 144 -- /usr/bin/steam -tenfoot &
