---------------------------
-- [[ HYPRLAND CONFIG ]] --
---------------------------

require("environment")
require("keybinds")
require("monitors")
require("window-rules")
require("workspaces")

-- [[ PROGRAMS ]] --
local terminal      = "kitty"
local menu          = "fuzzel"
local fileManager   = "Thunar"
local browser       = "floorp"
local pmenu         = "kitty -T pmenu -o font_size=16 pmenu"

-- [[ COMMANDS ]] --
local reloadWaybar          = "pkill waybar; waybar &"
local clipboardManager      = "cliphist list | fuzzel --dmenu --with-nth 2 | cliphist decode | wl-copy"
local screenshotCommand     = "hyprshot -z -m region -o $HOME/Pictures/Screenshots"
local screenLockerCommand   = "hyprlock"

-- [[ MAIN CONFIG ]] --
hl.config({
    input = {
        kb_layout       = "us",
        follow_mouse    = 1,
        sensitivity     = 0.1,
        accel_profile   = flat,

        touchpad = {
            natural_scroll          = true,
            scroll_factor           = 0.2,
            disable_while_typing    = true,
        },
    },

    general = {
        gaps_in             = 0,
        gaps_out            = 0,
        border_size         = 2,
        resize_on_border    = true,
        allow_tearing       = true,
        layout              = "master",

        col = {
            active_border   = { colors = {"rgb(173,142,230)", "rgb(122,162,247)"}, angle = 45 },
            inactive_border = "rgb(50,52,74)",
        },
    },
})

-- [[ APPEARANCE ]] --
hl.config({
    blur        = { enabled = false },
    animations  = { enabled = false },
    decoration  = { rounding = 0 },
    misc = {
        force_default_wallpaper = -1,
        disable_hyprland_logo   = false,
    },
})

hl.device({
    name        = "logitech-g502-hero-gaming-mouse",
    sensitivity = -0.1,
})

-- [[ LAYOUTS ]] --
hl.config =({
    master = {
        new_status = "master",
        new_on_top = true,
        mfact = 0.65,
    },
})

--[[ AUTOSTARTS ]]--
hl.on("hyprland.start", function ()
    hl.exec_cmd("swaync")
    hl.exec_cmd("waybar")
    hl.exec_cmd("qjackctl")
    hl.exec_cmd("nm-applet")
    hl.exec_cmd("waypaper --restore")
    hl.exec_cmd("openrgb")
    hl.exec_cmd("systemctl --user start hyprpolkitagent")

    hl.exec_cmd("wl-paste --type text --watch cliphist store")
    hl.exec_cmd("wl-paste --type image --watch cliphist store")

    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
end)

--[[            OLD CONFIG ---------------------
xwayland {
    force_zero_scaling = true
}]]--
