------------------
-- WINDOW RULES --
------------------

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/
hl.window_rule({
    name  = "steam-settings",
    match = { title = "Steam Settings" },
    float = true,
})

hl.window_rule({
    name  = "thunar-file-transfer",
    match = { title = "File Operation Progress" },
    float = true,
})

hl.window_rule({
    name  = "file-picker",
    match = { class = "xdg-desktop-portal-gtk" },
    float = true,
})

hl.window_rule({
    name  = "power-menu",
    match = { title = "pmenu" },
    float = true,
    size  = { "600", "500" },
})

hl.window_rule({
    name  = "about-reaper",
    match = { title = "^(?i)about reaper.*$" },
    float = true,
})

hl.window_rule({
    name  = "suppress-maximize-events",
    match = { class = ".*" },

    suppress_event = "maximize",
})

hl.window_rule({
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },

    no_focus = true,
})
