-- SPDX-License-Identifier: MPL-2.0
local _, addon = ...

function addon.ChooseMusicText(key)
    local db = addon.db
    if not db or not db.musicEnabled or (db.musicChance or 0) <= 0 then return nil end
    if math.random(100) > db.musicChance then return nil end
    local language = db.outputLanguage or "deDE"
    local texts = addon.musicRP[language] and addon.musicRP[language][key]
    if not texts then texts = addon.musicRP.deDE[key] end
    if type(texts) ~= "table" or #texts == 0 then return nil end
    return texts[math.random(#texts)]
end
