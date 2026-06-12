#! /bin/sh

scrcpy --render-driver opengles2 --video-source camera --camera-id=0 --camera-size=1920x1080 --camera-fps=60 --capture-orientation=0 --v4l2-sink=/dev/video2 --no-window --no-audio-playback --select-usb
