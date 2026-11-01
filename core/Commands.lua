-- SPDX-License-Identifier: MPL-2.0
local _, addon = ...
SLASH_KRIEGERRP1 = "/krp"
SLASH_KRIEGERRP2 = "/kriegerrp"
local function notify(message)
    print("|cffffaa55KriegerRP:|r " .. tostring(message))
end
addon.Notify = notify
local function keys()
    local list = {}
    for name in pairs(addon.localeData.deDE.texts or {}) do
        list[#list + 1] = name
    end
    table.sort(list)
    return list
end
local languages = {de="deDE", en="enUS", fr="frFR", dede="deDE", enus="enUS", frfr="frFR"}
local channels = {SAY=true, YELL=true, AUTO=true, PARTY=true, RAID=true, INSTANCE_CHAT=true}
local function number(value, limit)
    if not value:match("^%d+$") then return nil end
    local n = tonumber(value)
    if n and n <= limit then return n end
    return nil
end
local function help()
    notify("/krp help | status | list | ambient | debug")
    notify("/krp <SCHLUESSEL> z.B. /krp SHIELD_BLOCK")
    notify("/krp chance 0-100 | cooldown 0-3600 | racial 0-100")
    notify("/krp language deDE|enUS|frFR")
    notify("/krp channel SAY|YELL|AUTO|PARTY|RAID|INSTANCE_CHAT")
    notify("Mit *...* markierte Texte werden als /me ausgegeben.")
end
SlashCmdList["KRIEGERRP"] = function(message)
    local input = (message or ""):match("^%s*(.-)%s*$")
    local cmd, arg = input:match("^(%S+)%s*(.-)%s*$")
    cmd = cmd and cmd:lower() or "help"
    arg = arg or ""
    if not addon.ready then notify("Noch nicht initialisiert."); return end
    if cmd == "help" or cmd == "?" then help()
    elseif cmd == "status" then
        notify("Chance " .. addon.db.textChance .. "% | Cooldown " .. addon.db.cooldown ..
            "s | Volkstexte " .. addon.db.racialTextChance .. "% | " .. addon.db.outputLanguage ..
            " | Kanal " .. addon.db.chatChannel)
    elseif cmd == "list" then
        local list = keys()
        notify(#list .. " Fähigkeits-Schlüssel:")
        for i = 1, #list, 7 do
            local group = {}
            for j = i, math.min(i + 6, #list) do group[#group + 1] = list[j] end
            notify(table.concat(group, ", "))
        end
    elseif cmd == "ambient" then
        addon.TryAmbient()
    elseif cmd == "debug" then
        local _, class = UnitClass("player")
        notify("Bereit=" .. tostring(addon.ready) .. " Klasse=" .. tostring(class) ..
               " | Sprachregeln=" .. tostring(type(_G.RPChatMod) == "table"))
    elseif cmd == "language" then
        local selected = languages[arg:lower()]
        if not selected then notify("Benutzung: /krp language deDE|enUS|frFR"); return end
        addon.db.outputLanguage = selected
        notify("Ausgabesprache: " .. selected)
    elseif cmd == "channel" then
        arg = arg:upper()
        if not channels[arg] then notify("Ungültiger Chatkanal."); return end
        addon.db.chatChannel = arg
        notify("Kanal: " .. arg)
    elseif cmd == "chance" or cmd == "cooldown" or cmd == "racial" then
        local limit = cmd == "cooldown" and 3600 or 100
        local n = number(arg, limit)
        if not n then notify("Ungültiger Wert (0-" .. limit .. ")."); return end
        local field = cmd == "chance" and "textChance" or
                      (cmd == "cooldown" and "cooldown" or "racialTextChance")
        addon.db[field] = n
        notify(field .. ": " .. n)
    else
        local key = input:upper()
        if not addon.localeData.deDE.texts[key] then
            notify("Unbekannter Fähigkeits-Schlüssel: " .. key .. " (/krp list)")
            return
        end
        -- Chance, Cooldown or class filters intentionally produce no chat warning.
        addon.TryText(key)
    end
end
