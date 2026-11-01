-- SPDX-License-Identifier: MPL-2.0
local _, addon = ...
addon.defaults = {
    textChance = 100, cooldown = 0, racialTextChance = 40,
    outputLanguage = "deDE", chatChannel = "SAY",
    ambientChance = 30, ambientEnabled = false, ambientInCombat = false,
    ambientMinInterval = 120, ambientMaxInterval = 300,
}
