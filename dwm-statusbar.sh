#! /usr/bin/env bash

while [ true ]; do
    DATE=$(date +"%F")
    TIME=$(date +"%R")
    BAT_STATUS=$(cat /sys/class/power_supply/BAT0/status)
    BAT_PERCENT=$(cat /sys/class/power_supply/BAT0/capacity)%
    VOLUME=$(wpctl get-volume @DEFAULT_AUDIO_SINK@)
    BRIGHTNESS_PERCENT=$(brightnessctl g)%

    if [ $BAT_STATUS == "Charging" ]; then
        BAT_STATUS_ICON="↑"
    elif [ $BAT_STATUS == "Discharging" ]; then
        BAT_STATUS_ICON="↓"
    else
        BAT_STATUS_ICON=""
    fi

    if [[ $VOLUME == *"MUTED"* ]]; then
        VOLUME="MUTE"
    else
        VOLUME=$(echo $VOLUME | awk -F': ' '{printf "%.0f%%\n", $2 * 100}')
    fi

    xsetroot -name "[SCRN: $BRIGHTNESS_PERCENT] [VOL: $VOLUME] [BAT: $BAT_PERCENT$BAT_STATUS_ICON] [$TIME] [$DATE]"
    sleep 1s
done
