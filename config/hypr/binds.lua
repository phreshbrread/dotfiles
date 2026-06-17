--------------
-- KEYBINDS --
--------------

-- Set mod key
local mainMod = "SUPER"

-- Set programs
local terminal    = "kitty"
local fileManager = "Thunar"
local menu        = "fuzzel"
local pmenu       = "kitty -T pmenu -o font_size=16 pmenu"
local browser     = "floorp"
local browserPriv = "floorp --private-window"
local screenRec   = "com.dec05eba.gpu_screen_recorder"
local zoomer      = "woomer --monitor DP-1"

-- Other shortcuts
local reloadWaybar      = "pkill waybar; waybar &"
local clipboardManager  = "cliphist list | fuzzel --dmenu --with-nth 2 | cliphist decode | wl-copy"
local screenshotCommand = "hyprshot -z -m region -o $HOME/Pictures/Screenshots"
local lockScreen        = "hyprlock"
local exitHyprland      = "command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"

-- Window management
hl.bind(mainMod .. " + J",     hl.dsp.layout("togglesplit"))    -- dwindle only
hl.bind(mainMod .. " + C",     hl.dsp.window.close())
--hl.bind(mainMod .. " + P",     hl.dsp.window.pseudo())
hl.bind(mainMod .. " + F",     hl.dsp.window.fullscreen({ action = "toggle" }))
hl.bind(mainMod .. " + Space", hl.dsp.window.float({ action = "toggle" }))

-- Program shortcuts
hl.bind(mainMod .. " + E",         hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + R",         hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + V",         hl.dsp.exec_cmd(clipboardManager))
hl.bind(mainMod .. " + Z",         hl.dsp.exec_cmd(zoomer))
hl.bind(mainMod .. " + P",         hl.dsp.exec_cmd(pmenu))
hl.bind(mainMod .. " + B",         hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + Return",    hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + SHIFT + M", hl.dsp.exec_cmd(exitHyprland))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.exec_cmd(lockScreen))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd(screenshotCommand))
hl.bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd(reloadWaybar))
hl.bind(mainMod .. " + SHIFT + B", hl.dsp.exec_cmd(browserPriv))
hl.bind(           "ALT + Z",      hl.dsp.exec_cmd(screenRec))
hl.bind(           "XF86LaunchB",  hl.dsp.exec_cmd(menu))

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))

-- Alt / super + tab
hl.bind(mainMod .. " + Tab", function()
    hl.dispatch(hl.dsp.window.cycle_next({ prev = true }))
    hl.dispatch(hl.dsp.window.bring_to_top())
end)
hl.bind(        "ALT + Tab", function()
    hl.dispatch(hl.dsp.window.cycle_next({ prev = true }))
    hl.dispatch(hl.dsp.window.bring_to_top())
end)
hl.bind(mainMod .. " + SHIFT + Tab", function()
    hl.dispatch(hl.dsp.window.cycle_next())
    hl.dispatch(hl.dsp.window.bring_to_top())
end)
hl.bind(        "ALT + SHIFT + Tab", function()
    hl.dispatch(hl.dsp.window.cycle_next())
    hl.dispatch(hl.dsp.window.bring_to_top())
end)

-- Move window with mainMod + arrow keys
hl.bind(mainMod .. " + SHIFT + up",    hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + down",  hl.dsp.window.move({ direction = "down" }))
hl.bind(mainMod .. " + SHIFT + left",  hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.move({ direction = "right" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Move & resize windows with mouse
hl.bind(mainMod .. " + mouse:272",         hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + SHIFT + mouse:272", hl.dsp.window.resize(), { mouse = true })
hl.bind(mainMod .. " + mouse:273",         hl.dsp.window.resize(), { mouse = true })

-- Monitor brightness control
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 5%-"), { locked = true, repeating = true })

-- Keyboard brightness control
hl.bind("XF86KbdBrightnessUp",   hl.dsp.exec_cmd("brightnessctl -d *::kbd_backlight set 10%+"), { locked = true, repeating = true })
hl.bind("XF86KbdBrightnessDown", hl.dsp.exec_cmd("brightnessctl -d *::kbd_backlight set 10%-"), { locked = true, repeating = true })

-- Volume control
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),       { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),     { locked = true, repeating = true })

-- Audio playback control
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),               { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"),         { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"),         { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),           { locked = true })
hl.bind("XF86AudioStop",  hl.dsp.exec_cmd("playerctl --all-players stop"), { locked = true })

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key,         hl.dsp.focus({ workspace = i}))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Scratchpad (special workspace)
--hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("magic"))
--hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))
