#! /run/current-system/sw/bin/bash

DATE=$(date +"%F")
TIME=$(date +"%R")
BAT_PERCENT=$(cat /sys/class/power_supply/BAT0/capacity)%
BAT_STATUS=$(cat /sys/class/power_supply/BAT0/status)

if [ $BAT_STATUS == "Charging" ]; then
    BAT_STATUS_ICON="↑"
elif [ $BAT_STATUS == "Discharging" ]; then
    BAT_STATUS_ICON="↓"
else
    BAT_STATUS_ICON=""
fi

xsetroot -name "[BAT:$BAT_PERCENT$BAT_STATUS_ICON] [$TIME] [$DATE]"
sleep 1s # Update every second
