-- Set mod key
local mainMod = "SUPER"

-- Set programs
local terminal      = "kitty"
local fileManager   = "Thunar"
local menu          = "fuzzel"
local pmenu         = "kitty -T pmenu -o font_size=16 pmenu"
local browser       = "floorp"
local browserPriv   = "floorp --private-window"
local screenRec     = "com.dec05eba.gpu_screen_recorder"
local zoomer        = "woomer --monitor DP-1"

-- Other shortcuts
local reloadWaybar      = "pkill waybar; waybar &"
local clipboardManager  = "cliphist list | fuzzel --dmenu --with-nth 2 | cliphist decode | wl-copy"
local screenshotCommand = "hyprshot -z -m region -o $HOME/Pictures/Screenshots"
local screenLockCommand = "hyprlock"

-- Example binds, see https://wiki.hypr.land/Configuring/Basics/Binds/ for more
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + SHIFT + M", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))    -- dwindle only
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ action = "toggle" }))
--bind = $mainMod, F, fullscreen,

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key,             hl.dsp.focus({ workspace = i}))
    hl.bind(mainMod .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i }))
end

-- Example special workspace (scratchpad)
--hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("magic"))
--hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })


--[[ OLD BINDS TO PORT

bind = $mainMod, C, killactive,
bind = $mainMod, V, exec, $clipboardManager
bind = $mainMod, L, exec, $screenLockCommand
bind = $mainMod, E, exec, $fileManager
bind = $mainMod, R, exec, $menu
bind = , XF86LaunchB, exec, $menu
bind = $mainMod, SPACE, togglefloating,
bind = $mainMod, RETURN, exec, $terminal
bind = $mainMod SHIFT, M, exit,
bind = $mainMod SHIFT, S, exec, $screenshotCommand
bind = $mainMod SHIFT, R, exec, $reloadWaybar
bind = $mainMod, P, exec, $pmenu
bind = $mainMod, B, exec, $browser
bind = $mainMod SHIFT, B, exec, $browserPrivate
bind = ALT, Z, exec, $screenRecorder
bind = $mainMod, Z, exec, $zoomer

# Move focus with shift + arrow keys
bind = $mainMod, up, movefocus, u
bind = $mainMod, down, movefocus, d
bind = $mainMod, left, movefocus, l
bind = $mainMod, right, movefocus, r

# Alt / super + tab
bind = SUPER,       tab,    cyclenext,  prev
bind = ALT,         tab,    cyclenext,  prev
bind = SUPER SHIFT, tab,    cyclenext
bind = ALT SHIFT,   tab,    cyclenext
bind = SUPER,       tab,    alterzorder, top
bind = ALT,         tab,    alterzorder, top
bind = SUPER SHIFT, tab,    alterzorder, top
bind = ALT SHIFT,   tab,    alterzorder, top

# Move window with arrow keys
bind = $mainMod SHIFT, up, movewindow, u
bind = $mainMod SHIFT, down, movewindow, d
bind = $mainMod SHIFT, left, movewindow, l
bind = $mainMod SHIFT, right, movewindow,r

# Switch workspaces with mainMod + [0-9]
bind = $mainMod, 1, workspace, 1
bind = $mainMod, 2, workspace, 2
bind = $mainMod, 3, workspace, 3
bind = $mainMod, 4, workspace, 4
bind = $mainMod, 5, workspace, 5
bind = $mainMod, 6, workspace, 6
bind = $mainMod, 7, workspace, 7
bind = $mainMod, 8, workspace, 8
bind = $mainMod, 9, workspace, 9
bind = $mainMod, 0, workspace, 10

# Move active window to a workspace with mainMod + SHIFT + [0-9]
bind = $mainMod SHIFT, 1, movetoworkspace, 1
bind = $mainMod SHIFT, 2, movetoworkspace, 2
bind = $mainMod SHIFT, 3, movetoworkspace, 3
bind = $mainMod SHIFT, 4, movetoworkspace, 4
bind = $mainMod SHIFT, 5, movetoworkspace, 5
bind = $mainMod SHIFT, 6, movetoworkspace, 6
bind = $mainMod SHIFT, 7, movetoworkspace, 7
bind = $mainMod SHIFT, 8, movetoworkspace, 8
bind = $mainMod SHIFT, 9, movetoworkspace, 9
bind = $mainMod SHIFT, 0, movetoworkspace, 10

# Scroll through existing workspaces with mainMod + scroll
bind = $mainMod, mouse_down, workspace, e+1
bind = $mainMod, mouse_up, workspace, e-1

# Move & resize windows with mouse
bindm = $mainMod, mouse:272, movewindow         # L click move
bindm = $mainMod SHIFT, mouse:272, resizewindow # Shift + L click resize
bindm = $mainMod, mouse:273, resizewindow       # R click resize

# Monitor brightness control
binde = , XF86MonBrightnessUp, exec, brightnessctl set 5%+
binde = , XF86MonBrightnessDown, exec, brightnessctl set 5%-

# Keyboard brightness control
binde = , XF86KbdBrightnessUp, exec, brightnessctl -d *::kbd_backlight set 10%+
binde = , XF86KbdBrightnessDown, exec, brightnessctl -d *::kbd_backlight set 10%-

# Volume control
binde = , XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+
binde = , XF86AudioLowerVolume, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%-
binde = , XF86AudioMute,        exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle

# Audio playback control
bind = , XF86AudioPlay, exec, playerctl play-pause
bind = , XF86AudioNext, exec, playerctl next
bind = , XF86AudioPrev, exec, playerctl previous
bind = , XF86AudioStop, exec, playerctl --all-players stop
--]]
