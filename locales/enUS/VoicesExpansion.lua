-- SPDX-License-Identifier: CC-BY-SA-4.0
-- Additive, original warrior spell and ambient voices; no event handlers.
local _, addon = ...
local root = addon.localeData.enUS
local function add(existing, texts)
    if type(existing) ~= "table" then return end
    for _, line in ipairs(texts) do
        local found = false
        for _, old in ipairs(existing) do if old == line then found = true; break end end
        if not found then existing[#existing + 1] = line end
    end
end
add(root.texts.TAUNT.gruppe, { "Over here! My companions have more important work to do.", "*strikes the shield rim and steps deliberately out of cover.*" })
add(root.texts.SHIELD_WALL.gruppe, { "This shield is not a promise for later. It stands now.", "*plants both boots and raises the shield like a wall.*" })
add(root.texts.CHARGE.gruppe, { "If the road is too long, I shorten it with a running start.", "*drops behind a shoulder and surges forward with purpose.*" })
add(root.texts.EXECUTE.gruppe, { "A battle ends not with words, but with a decision.", "*tightens the grip and gathers strength for a decisive strike.*" })
add(root.texts.BATTLE_SHOUT.gruppe, { "Breathe! Shields up! We all come home together!", "*raises a weapon and calls companions shoulder to shoulder.*" })
add(root.ambient.DWARF, { "My shield has more dents than I have excuses. And that's saying something.", "*checks the axe haft and shakes a skeptical beard.*" })
add(root.ambient.GNOME, { "My armor has a backup plan. And a backup plan for the backup plan.", "*tightens a helmet screw with a tiny screwdriver.*" })
add(root.ambient.ORC, { "A true victory brings our companions home standing.", "*sets the axe down and silently inspects the blade.*" })
