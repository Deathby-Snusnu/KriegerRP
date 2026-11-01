-- SPDX-License-Identifier: MPL-2.0
local _, addon = ...
_G.KriegerRP = addon
addon.ready = false
local nextAllowed = 0
local function permitted()
    if not addon.ready or not addon.db then return false end
    local _, class = UnitClass("player")
    if class ~= "WARRIOR" then return false end
    return GetTime() >= nextAllowed and math.random(100) <= addon.db.textChance
end
local function emit(text)
    if type(text) ~= "string" or not addon.SendText(text) then return false end
    nextAllowed = GetTime() + addon.db.cooldown
    return true
end
function addon.TryText(key)
    if not permitted() then return false end
    return emit(addon.BuildText(key))
end
function addon.TryAmbient(_, force)
    if force == nil then force = true end
    if not permitted() then return false end
    if not force and not addon.db.ambientEnabled then return false end
    if addon.db.ambientInCombat == false and type(UnitAffectingCombat) == "function"
        and UnitAffectingCombat("player") then return false end
    if math.random(100) > addon.db.ambientChance then return false end
    return emit(addon.BuildAmbient())
end
local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_LOGIN")
frame:SetScript("OnEvent", function()
    addon.InitializeDatabase()
    addon.ready = true
    if addon.ResetAmbientTimer then addon.ResetAmbientTimer() end
    print("|cffffaa55KriegerRP 0.1.0 geladen.|r /krp help")
end)
