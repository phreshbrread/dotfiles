#! /bin/sh

# For all WMs
pgrep nm-applet          || nm-applet &
pgrep qpwgraph           || qpwgraph &
pgrep lxqt-notificationd || lxqt-notificationd &
pgrep openrgb            || openrgb &
pgrep kdeconnectd        || kdeconnectd &

# X only
# TODO:
# Hyprsunset equivalent
# Clipboard manager
# D-bus
if [ "$XDG_SESSION_TYPE" == "x11" ]; then
    nitrogen --restore
    picom    --backend glx
fi

# Wayland only
if [ "$XDG_SESSION_TYPE" == "wayland" ]; then
fi
