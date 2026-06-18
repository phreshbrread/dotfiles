----------------
-- WORKSPACES --
----------------

-- 1-5 -> Gigabyte
for w = 1, 5 do
    hl.workspace_rule({ workspace = tostring(w), monitor = "desc:GIGA-BYTE TECHNOLOGY CO. LTD. G27F 21282B001333", default = (w == 1) })
end

-- 6-10 -> BenQ
for w = 6, 10 do
    local ws_name = (w == 10) and "0" or tostring(w)
    hl.workspace_rule({ workspace = ws_name, monitor = "desc:BNQ BenQ RL2455 65F03137SL0", default = (w == 6) })
end
