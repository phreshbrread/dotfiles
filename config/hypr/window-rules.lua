--[[ OLD RULES TO PORT
# Window rules
windowrule {
  name          = Steam Settings
  match:title   = Steam Settings
  float         = true
}
windowrule {
  name          = Thunar File Transfer
  match:title   = File Operation Progress
  float         = true
}
windowrule {
  name          = File Picker
  match:class   = xdg-desktop-portal-gtk
  float         = true
}
windowrule {
  name          = Power menu
  match:title   = pmenu
  float         = true
  size          = 600 500
}
windowrule {
  name          = REAPER welcome
  match:title   = ^(?i)about reaper.*$
  center        = true
}
windowrule {
    name                = Fix Xwayland Drags
    match:class         = ^$
    match:title         = ^$
    match:xwayland      = true
    match:float         = true
    match:fullscreen    = false
    match:pin           = false
    no_focus            = true
}
]]--
