------------------
--- BAR CONFIG ---
------------------

-- Create widgets
mytextclock = wibox.widget.textclock()      -- Text clock
mybattery_widget = wibox.widget.textbox()   -- Battery

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
    awful.button({}, 1, function(t) t:view_only() end),
    awful.button({ modkey }, 1, function(t)
        if client.focus then
            client.focus:move_to_tag(t)
        end
    end),
    awful.button({}, 3, awful.tag.viewtoggle),
    awful.button({ modkey }, 3, function(t)
        if client.focus then
            client.focus:toggle_tag(t)
        end
    end),
    awful.button({}, 4, function(t) awful.tag.viewnext(t.screen) end),
    awful.button({}, 5, function(t) awful.tag.viewprev(t.screen) end)
)

local tasklist_buttons = gears.table.join(
    awful.button({}, 1, function(c)
        if c == client.focus then
            c.minimized = true
        else
            c:emit_signal(
                "request::activate",
                "tasklist",
                { raise = true }
            )
        end
    end),
    awful.button({}, 3, function()
        awful.menu.client_list({ theme = { width = 250 } })
    end),
    awful.button({}, 4, function()
        awful.client.focus.byidx(1)
    end),
    awful.button({}, 5, function()
        awful.client.focus.byidx(-1)
    end))

awful.screen.connect_for_each_screen(function(s)
    -- Each screen has its own tag table.
    awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
        awful.button({}, 1, function() awful.layout.inc(1) end),
        awful.button({}, 3, function() awful.layout.inc(-1) end),
        awful.button({}, 4, function() awful.layout.inc(1) end),
        awful.button({}, 5, function() awful.layout.inc(-1) end)))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = taglist_buttons
    }

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons
    }

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s })

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            -- mylauncher,
            s.mytaglist,
            s.mypromptbox,
        },
        s.mytasklist, -- Middle widget
        {             -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            wibox.widget.systray(),
            mykeyboardlayout,
            mybattery_widget,
            mytextclock,
            s.mylayoutbox,
        },
    }
end)

--- Battery Widget ---
-- Update function
local function update_battery()
    local capacity_file = io.open("/sys/class/power_supply/BAT0/capacity", "r")
    local status_file = io.open("/sys/class/power_supply/BAT0/status", "r")

    if capacity_file and status_file then
        local capacity = capacity_file:read("*n")
        local status = status_file:read("*l")
        capacity_file:close()
        status_file:close()

        local icon
        if capacity >= 95 then
            icon = ""
        elseif capacity < 80 then
          icon = ""
        elseif capacity < 55 then
          icon = ""
        elseif capacity < 35 then
          icon = ""
        elseif capacity < 15 then
            icon = ""
        end

        if status == "Charging" then
            icon = ""
        end

        mybattery_widget.text = string.format(" %s %d%% ", icon, capacity)
    else
        mybattery_widget.text = ""
    end
end

-- Update timer
gears.timer {
    timeout = 10,
    call_now = true,
    autostart = true,
    callback = update_battery
}
