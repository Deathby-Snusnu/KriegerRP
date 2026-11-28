-- SPDX-License-Identifier: CC-BY-SA-4.0
-- Additive, original warrior spell and ambient voices; no event handlers.
local _, addon = ...
local root = addon.localeData.frFR
local function add(existing, texts)
    if type(existing) ~= "table" then return end
    for _, line in ipairs(texts) do
        local found = false
        for _, old in ipairs(existing) do if old == line then found = true; break end end
        if not found then existing[#existing + 1] = line end
    end
end
add(root.texts.TAUNT.gruppe, { "Par ici ! Mes compagnons ont plus important à faire.", "*frappe le bord du bouclier et sort délibérément de son abri.*" })
add(root.texts.SHIELD_WALL.gruppe, { "Ce bouclier n'est pas une promesse pour demain. Il tient maintenant.", "*plante ses bottes et dresse son bouclier comme un mur.*" })
add(root.texts.CHARGE.gruppe, { "Si le chemin est trop long, je le raccourcis en prenant de l'élan.", "*baisse l'épaule et fonce avec détermination.*" })
add(root.texts.EXECUTE.gruppe, { "Un combat ne se termine pas par des mots, mais par une décision.", "*resserre sa prise et rassemble ses forces pour un coup décisif.*" })
add(root.texts.BATTLE_SHOUT.gruppe, { "Respirez ! Boucliers levés ! Nous rentrerons ensemble !", "*lève son arme et rassemble ses compagnons épaule contre épaule.*" })
add(root.ambient.DWARF, { "Mon bouclier a plus de bosses que je n'ai d'excuses. C'est dire.", "*vérifie le manche de sa hache et secoue sa barbe d'un air sceptique.*" })
add(root.ambient.GNOME, { "Mon armure a un plan de secours, et un plan pour secourir ce plan.", "*resserre une vis du casque avec un minuscule tournevis.*" })
add(root.ambient.ORC, { "Une vraie victoire ramène aussi nos compagnons debout.", "*pose sa hache et examine sa lame en silence.*" })
