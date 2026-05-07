local mainMod = "SUPER"

-- Basic Actions
hl.bind(mainMod .. " + C", hl.dsp.killactive())
hl.bind(mainMod .. " + F", hl.dsp.fullscreen(0))
hl.bind(mainMod .. " + SPACE", hl.dsp.togglefloating())
hl.bind(mainMod .. " + SHIFT + M", hl.dsp.exit())

-- Exec Commands
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd(clipboardManager))
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd(screenLockCommand))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(menu))
hl.bind("XF86LaunchB", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd(screenshotCommand))
hl.bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd(reloadWaybar))
hl.bind(mainMod .. " + P", hl.dsp.exec_cmd(pmenu))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(browser))

-- Focus & Window Movement
hl.bind(mainMod .. " + up", hl.dsp.movefocus("u"))
hl.bind(mainMod .. " + down", hl.dsp.movefocus("d"))
hl.bind(mainMod .. " + left", hl.dsp.movefocus("l"))
hl.bind(mainMod .. " + right", hl.dsp.movefocus("r"))

hl.bind(mainMod .. " + SHIFT + up", hl.dsp.movewindow("u"))
hl.bind(mainMod .. " + SHIFT + down", hl.dsp.movewindow("d"))
hl.bind(mainMod .. " + SHIFT + left", hl.dsp.movewindow("l"))
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.movewindow("r"))

-- Cycling (Alt/Super + Tab)
hl.bind("SUPER + tab", hl.dsp.cyclenext("prev"))
hl.bind("ALT + tab", hl.dsp.cyclenext("prev"))
hl.bind("SUPER + SHIFT + tab", hl.dsp.cyclenext())
hl.bind("ALT + SHIFT + tab", hl.dsp.cyclenext())

-- Mouse
hl.bind(mainMod .. " + mouse_down", hl.dsp.workspace("e+1"))
hl.bind(mainMod .. " + mouse_up", hl.dsp.workspace("e-1"))

hl.bindm(mainMod .. " + mouse:272", hl.dsp.movewindow())
hl.bindm(mainMod .. " + SHIFT + mouse:272", hl.dsp.resizewindow())
hl.bindm(mainMod .. " + mouse:273", hl.dsp.resizewindow())

-- Brightness
hl.binde("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl set 5%+"))
hl.binde("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 5%-"))
hl.binde("XF86KbdBrightnessUp", hl.dsp.exec_cmd("brightnessctl -d *::kbd_backlight set 10%+"))
hl.binde("XF86KbdBrightnessDown", hl.dsp.exec_cmd("brightnessctl -d *::kbd_backlight set 10%-"))

-- Volume
hl.binde("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+"))
hl.binde("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%-"))
hl.binde("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"))

-- Media Controls
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"))
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"))
hl.bind("XF86AudioStop", hl.dsp.exec_cmd("playerctl --all-players stop"))

