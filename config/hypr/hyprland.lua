---------------------------
-- [[ HYPRLAND CONFIG ]] --
---------------------------

require("workspaces")
require("monitors")

-- [[ ENVIRONMENT ]] --
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_THEME", "Adwaita")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")
hl.env("QT_QPA_PLATFOAM", "wayland;xcb")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("QT_STYLE_OVERRIDE", "kvantum")

-- [[ PROGRAMS ]] --
local terminal      = "kitty"
local menu          = "fuzzel"
local fileManager   = "yazi"
local browser       = "floorp"
local pmenu         = "kitty -T pmenu -o font_size=16 pmenu"

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

    decoration = {
        rounding = 0,
    },

    blur = {
        enabled = false,
    },

    animations = {
        enabled = false,
    },
})

hl.device({
    name        = "logitech-g502-hero-gaming-mouse",
    sensitivity = -0.1,
})
