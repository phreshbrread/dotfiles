------------------
--- Autostarts ---
------------------

awful.spawn.once("nm-applet")
awful.spawn.once("nitrogen --restore")
awful.spawn.once("picom --backend glx")
awful.spawn.once("lxqt-notificationd")
awful.spawn.once("openrgb")
awful.spawn.once("kdeconnectd")
awful.spawn.once("qpwgraph")

-- TODO:
-- Hyprsunset equivalent
-- Clipboard manager
-- D-bus
