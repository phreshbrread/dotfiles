---------------------
-- HYPRLAND CONFIG --
---------------------

--- Import split configs ---
require("environment")
require("monitors")
require("binds")
require("window-rules")
require("anim")
require("permissions")
require("workspaces")

--- Autostarts ---
hl.on("hyprland.start", function ()
    hl.exec_cmd("waypaper --restore")
    hl.exec_cmd("waybar")
    hl.exec_cmd("hyprsunset")
    hl.exec_cmd("nm-applet")
    hl.exec_cmd("lxqt-notificationd")
    hl.exec_cmd("openrgb")
    hl.exec_cmd("systemctl --user start hyprpolkitagent")
    hl.exec_cmd("kdeconnectd")
    hl.exec_cmd("qpwgraph")

    -- Clipboard manager
    hl.exec_cmd("wl-paste --type text --watch cliphist store # Stores only text data")
    hl.exec_cmd("wl-paste --type image --watch cliphist store # Stores only image data")

    -- D-bus
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")

    -- Import theme env
    hl.exec_cmd("systemctl --user import-environment QT_QPA_PLATFORMTHEME QT_PLUGIN_PATH")
end)

--- General settings ---
hl.config({
    general = {
        layout           = "master",
        gaps_in          = 0,
        gaps_out         = 0,
        border_size      = 2,
        resize_on_border = true,
        allow_tearing    = true,

        col = {
            active_border   = { colors = {"rgb(173,142,230)", "rgb(122,162,247)"}, angle = 45 },
            inactive_border = "rgb(50,52,74)",
        },
    },

    decoration = {
        rounding       = 0,
        blur = {
            enabled   = true,
            size      = 3,
            passes    = 1,
            vibrancy  = 0.1696,
        },
    },

    misc = {
        force_default_wallpaper = -1,    -- Set to 0 or 1 to disable the anime mascot wallpapers
        disable_hyprland_logo   = false, -- If true disables the random hyprland logo / anime girl background. :(
    },

    xwayland = { force_zero_scaling = true },
})

--- Layout settings ---
hl.config({
    dwindle   = { preserve_split = true },
    master    = { new_status = "master" },
    scrolling = { fullscreen_on_one_column = true },
})

--- Input ---
hl.config({
    input = {
        kb_layout     = "us",
        follow_mouse  = 1,
        accel_profile = "flat",

        touchpad = {
            natural_scroll       = true,
            scroll_factor        = 0.2,
            disable_while_typing = true,
        },
    },
})

hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace"
})

--- Per-device settings ---
hl.device({
    name        = "logitech-g502-hero-gaming-mouse",
    sensitivity = -0.1,
})

hl.device({
    name    = "sony-interactive-entertainment-wireless-controller-touchpad",
    enabled = false,
})
