-- [[ WINDOW RULES ]] --
hl.window_rule({
    name    = "Steam Settings",
    match   = {title = "Steam Settings" },
    float   = true,
})
hl.window_rule({
    name    = "Thunar File Transfer",
    match   = { title = "File Operation Progress" },
    float   = true,
})
hl.window_rule({
    name    = "File Picker",
    match   = { class = "xdg-desktop-portal-gtk" },
    float   = true,
})
hl.window_rule({
    name    = "Power menu",
    match   = { title = "pmenu" },
    float   = true,
    size    = 600 500,
})
