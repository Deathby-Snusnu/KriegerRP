-- SPDX-License-Identifier: CC-BY-SA-4.0
-- Original spoken lines and emotes; song titles are internal inspiration metadata.
local _, addon = ...
addon.musicRP = { deDE = {}, enUS = {}, frFR = {} }
addon.musicRPReferences = {}
addon.musicRPReferences.CHARGE = { artist = "Metallica", song = "Fuel" }
addon.musicRP.deDE.CHARGE = { "Der Weg nach vorn ist kurz. Den Rest erledigt der Aufprall.", "*senkt die Schulter und stürmt ohne Zögern vorwärts.*" }
addon.musicRP.enUS.CHARGE = { "The road ahead is short. Impact handles the rest.", "*lowers a shoulder and charges without hesitation.*" }
addon.musicRP.frFR.CHARGE = { "La route est courte. L'impact fera le reste.", "*baisse l'épaule et charge sans hésiter.*" }
addon.musicRPReferences.BATTLE_SHOUT = { artist = "Amon Amarth", song = "Raise Your Horns" }
addon.musicRP.deDE.BATTLE_SHOUT = { "Für die Gefährten an unserer Seite! Und die, die uns fehlen!", "*hebt die Waffe und antwortet dem Echo mit einem Schlachtruf.*" }
addon.musicRP.enUS.BATTLE_SHOUT = { "For those beside us! And those we miss!", "*raises a weapon and answers the echo with a war cry.*" }
addon.musicRP.frFR.BATTLE_SHOUT = { "Pour ceux qui sont à nos côtés ! Et pour les absents !", "*lève son arme et répond à l'écho par un cri de guerre.*" }
addon.musicRPReferences.SHIELD_WALL = { artist = "Black Sabbath", song = "Iron Man" }
addon.musicRP.deDE.SHIELD_WALL = { "Manche Mauern bestehen aus Stein. Meine steht auf zwei Beinen.", "*rammt den Schild vor sich in den Boden und verharrt.*" }
addon.musicRP.enUS.SHIELD_WALL = { "Some walls are stone. Mine stands on two legs.", "*plants the shield ahead and holds position.*" }
addon.musicRP.frFR.SHIELD_WALL = { "Certains murs sont en pierre. Le mien tient sur deux jambes.", "*plante son bouclier devant lui et tient bon.*" }
addon.musicRPReferences.REND = { artist = "Slayer", song = "Raining Blood" }
addon.musicRP.deDE.REND = { "Kein Triumph ohne Preis. Heute fordert der Kampf ihn ein.", "*führt einen harten, knappen Hieb aus und weicht zurück.*" }
addon.musicRP.enUS.REND = { "No triumph comes without a price. Battle collects it today.", "*delivers a sharp, economical strike and steps back.*" }
addon.musicRP.frFR.REND = { "Nul triomphe sans prix. La bataille le réclame aujourd'hui.", "*porte un coup bref et brutal puis recule.*" }
addon.musicRPReferences.TAUNT = { artist = "Pantera", song = "Walk" }
addon.musicRP.deDE.TAUNT = { "Respekt bekommt Ihr nicht durch lautes Auftreten.", "*klopft einmal auf den Schild und fixiert den Gegner.*" }
addon.musicRP.enUS.TAUNT = { "Loud boasting will not earn you respect.", "*taps the shield once and fixes a steady gaze on the foe.*" }
addon.musicRP.frFR.TAUNT = { "Vous ne gagnerez pas le respect en criant.", "*frappe une fois son bouclier et fixe l'ennemi.*" }
addon.musicRPReferences.AFTER_BATTLE = { artist = "Guns N' Roses", song = "November Rain" }
addon.musicRP.deDE.AFTER_BATTLE = { "Der Regen wäscht den Staub fort. Nicht alle Erinnerungen.", "*setzt sich schweigend und legt die Waffe neben sich.*" }
addon.musicRP.enUS.AFTER_BATTLE = { "Rain washes away dust. Not every memory.", "*sits quietly and sets the weapon down nearby.*" }
addon.musicRP.frFR.AFTER_BATTLE = { "La pluie emporte la poussière. Pas tous les souvenirs.", "*s'assied en silence et pose son arme à côté.*" }
addon.musicRPReferences.LAST_STAND = { artist = "Metallica", song = "The Unforgiven" }
addon.musicRP.deDE.LAST_STAND = { "Manche Fehler kann ich nicht ändern. Aber diesen Kampf noch.", "*richtet sich schwer atmend ein letztes Mal auf.*" }
addon.musicRP.enUS.LAST_STAND = { "I cannot undo every mistake. But I can still fight this battle.", "*straightens up one last time, breathing hard.*" }
addon.musicRP.frFR.LAST_STAND = { "Je ne peux effacer mes erreurs. Mais je peux encore me battre.", "*se redresse une dernière fois, le souffle court.*" }
addon.musicRPReferences.DEFENSIVE_STANCE = { artist = "Sepultura", song = "Refuse/Resist" }
addon.musicRP.deDE.DEFENSIVE_STANCE = { "Rückzug ist eine Entscheidung. Heute treffe ich sie nicht.", "*verlagert das Gewicht und schließt die Lücke in der Deckung.*" }
addon.musicRP.enUS.DEFENSIVE_STANCE = { "Retreat is a choice. Not one I make today.", "*shifts weight and closes a gap in the guard.*" }
addon.musicRP.frFR.DEFENSIVE_STANCE = { "Reculer est un choix. Pas celui que je fais aujourd'hui.", "*déplace son poids et referme sa garde.*" }

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
