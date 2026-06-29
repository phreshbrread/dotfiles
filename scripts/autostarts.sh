#! /bin/sh

# For all WMs
pgrep nm-applet          || nm-applet &
pgrep qpwgraph           || qpwgraph &
pgrep lxqt-notificationd || lxqt-notificationd &
pgrep openrgb            || openrgb &
pgrep kdeconnectd        || kdeconnectd &

# Import theme env
systemctl --user import-environment QT_QPA_PLATFORMTHEME QT_PLUGIN_PATH

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
    pgrep waybar || waybar &
    waypaper --restore

    # Clipboard manager
    wl-paste --type text --watch cliphist store # Stores only text data
    wl-paste --type image --watch cliphist store # Stores only image datafi

    # D-bus
    dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
fi

# Hyprland specific
if [ "$XDG_SESSION_DESKTOP" == "Hyprland" ]; then
    hyprsunset &
    systemctl --user start hyprpolkitagent
fi
