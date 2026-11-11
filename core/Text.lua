-- SPDX-License-Identifier: MPL-2.0
local _, addon = ...

-- Protected WoW clients may return secret strings for unit names.
-- Use a safe placeholder before comparison or text interpolation.
local function SafeUnitName(unit)
    local name = UnitName(unit)
    if type(issecretvalue) == "function" and issecretvalue(name) then
        return nil -- Never substitute awkward generic target names.
    end
    return name
end

-- Only directed attacks and taunts may use the selected enemy's name.
-- Shouts, defensive abilities and area attacks must remain untargeted.
local targeted = {
    HEROIC_STRIKE=true, CHARGE=true, REND=true, HAMSTRING=true, EXECUTE=true,
    SUNDER_ARMOR=true, SHIELD_BASH=true, TAUNT=true, REVENGE=true,
    OVERPOWER=true, MORTAL_STRIKE=true, BLOODTHIRST=true, INTERCEPT=true,
    PUMMEL=true, MOCKING_BLOW=true, DISARM=true, SLAM=true, DEVASTATE=true,
    SHIELD_SLAM=true, CONCUSSION_BLOW=true, VICTORY_RUSH=true,
    SPEARING_STRIKE=true,
}
local friendlyActions = { BATTLEFIELD_AID=true, FORMATION=true }
local function enemyName(key)
    if friendlyActions[key] then
        if type(UnitExists) ~= "function" or not UnitExists("target")
            or type(UnitCanAssist) ~= "function"
            or not UnitCanAssist("player", "target")
            or type(UnitName) ~= "function" then return nil end
        if type(UnitIsUnit) == "function" and UnitIsUnit("target", "player") then return nil end
        return SafeUnitName("target")
    end
    if not targeted[key] or type(UnitExists) ~= "function" or not UnitExists("target") then return nil end
    if type(UnitCanAttack) == "function" and not UnitCanAttack("player", "target") then return nil end
    if type(UnitIsUnit) == "function" and UnitIsUnit("target", "player") then return nil end
    if type(UnitName) ~= "function" then return nil end
    return SafeUnitName("target")
end
local function choose(pool)
    if type(pool) ~= "table" or #pool < 1 then return nil end
    return pool[math.random(#pool)]
end
function addon.BuildText(key)
    if type(key) ~= "string" then return nil end
    local lang = addon.db and addon.db.outputLanguage or "deDE"
    if not addon.availableLocales[lang] then lang = "deDE" end
    local localized = addon.localeData[lang] or addon.localeData.deDE
    local entry = (localized.texts and localized.texts[key]) or
        (addon.localeData.deDE.texts and addon.localeData.deDE.texts[key])
    if not entry then return nil end
    local target = enemyName(key)
    local pool = target and entry.ziel or entry.gruppe
    if type(pool) ~= "table" or #pool == 0 then pool = entry.gruppe end
    local _, race = UnitRace("player")
    local racial = localized.racial or addon.localeData.deDE.racial
    local raceEntries = racial and racial[addon.NormalizeRace(race)]
    local racePool = raceEntries and raceEntries[key]
    if type(racePool) == "table" and #racePool > 0
        and math.random(100) <= (addon.db.racialTextChance or 40) then
        pool = racePool
    end
    local line = choose(pool)
    if type(line) ~= "string" then return nil end
    if not target and line:find("%s", 1, true) then
        local alternatives = {}
        for _, candidate in ipairs(entry.gruppe or {}) do
            if type(candidate) == "string" and not candidate:find("%s", 1, true) then
                alternatives[#alternatives + 1] = candidate
            end
        end
        if #alternatives == 0 then return nil end
        line = choose(alternatives)
    end
    return (line:gsub("%%([s%%])", function(token)
        if token == "%" then return "%" end
        return target or ""
    end))
end
function addon.BuildAmbient()
    local lang = addon.db and addon.db.outputLanguage or "deDE"
    if not addon.availableLocales[lang] then lang = "deDE" end
    local data = (addon.localeData[lang] or {}).ambient or addon.localeData.deDE.ambient
    if not data then return nil end
    local _, race = UnitRace("player")
    return choose(data[addon.NormalizeRace(race)] or data.NEUTRAL)
end
