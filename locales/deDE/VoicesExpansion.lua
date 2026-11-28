-- SPDX-License-Identifier: CC-BY-SA-4.0
-- Additive, original warrior spell and ambient voices; no event handlers.
local _, addon = ...
local root = addon.localeData.deDE
local function add(existing, texts)
    if type(existing) ~= "table" then return end
    for _, line in ipairs(texts) do
        local found = false
        for _, old in ipairs(existing) do if old == line then found = true; break end end
        if not found then existing[#existing + 1] = line end
    end
end
add(root.texts.TAUNT.gruppe, { "Hierher! Meine Gefährten haben Wichtigeres zu tun.", "*schlägt gegen den Schildrand und tritt bewusst aus der Deckung.*" })
add(root.texts.SHIELD_WALL.gruppe, { "Dieser Schild ist kein Versprechen für später. Er steht jetzt.", "*verankert beide Stiefel und richtet den Schild wie eine Mauer auf.*" })
add(root.texts.CHARGE.gruppe, { "Wenn der Weg zu lang ist, verkürze ich ihn eben mit Anlauf.", "*duckt sich hinter die Schulter und stürmt mit entschlossenem Schritt vorwärts.*" })
add(root.texts.EXECUTE.gruppe, { "Ein Kampf endet nicht mit Worten, sondern mit einer Entscheidung.", "*fasst die Waffe fester und sammelt die letzte Kraft für einen gezielten Hieb.*" })
add(root.texts.BATTLE_SHOUT.gruppe, { "Einatmen! Schild hoch! Wir kommen gemeinsam zurück!", "*hebt die Waffe und ruft die Gefährten Schulter an Schulter.*" })
add(root.ambient.DWARF, { "Mein Schild hat mehr Dellen als ich Ausreden. Und das will etwas heißen.", "*prüft den Axtgriff und schüttelt skeptisch den Bart.*" })
add(root.ambient.GNOME, { "Meine Rüstung hat einen Notfallplan. Und einen Notfallplan für den Notfallplan.", "*zieht mit einem winzigen Schraubendreher die Helmschraube fest.*" })
add(root.ambient.ORC, { "Ein wahrer Sieg lässt auch den Gefährten aufrecht heimkehren.", "*legt die Axt beiseite und überprüft schweigend die Klinge.*" })
