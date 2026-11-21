-- SPDX-License-Identifier: CC-BY-SA-4.0
-- Individually authored general RP dialogue and emotes, not song quotations.
local _, addon = ...
local entries = {
    CHARGE = { deDE = { "Ein guter Anfang braucht keine Rede. Nur den ersten Schritt.", "*setzt sich mit einem kurzen Ruck in Bewegung.*" }, enUS = { "A good beginning needs no speech. Just the first step.", "*surges forward with one sharp movement.*" }, frFR = { "Un bon départ n'exige aucun discours. Juste le premier pas.", "*s'élance d'un mouvement vif.*" } },
    TAUNT = { deDE = { "Wenn Ihr schon Ärger sucht, dann wenigstens den richtigen.", "*schlägt einmal gegen den Schild und wartet.*" }, enUS = { "If you insist on trouble, choose the right opponent.", "*strikes the shield once and waits.*" }, frFR = { "Si vous cherchez des ennuis, choisissez le bon adversaire.", "*frappe une fois son bouclier puis attend.*" } },
    SHIELD_BLOCK = { deDE = { "Eine Handbreit Stahl kann einem einen ganzen Tag schenken.", "*verlagert das Gewicht hinter die verstärkte Schildkante.*" }, enUS = { "A handspan of steel can buy a whole day.", "*shifts weight behind the reinforced shield edge.*" }, frFR = { "Une largeur de main d'acier peut offrir une journée entière.", "*se cale derrière le bord renforcé du bouclier.*" } },
    REND = { deDE = { "Kein unnötiger Schwung. Ein sicherer Treffer reicht.", "*führt einen knappen Hieb mit kontrollierter Kraft aus.*" }, enUS = { "No wasted motion. One clean strike will do.", "*delivers a compact, controlled blow.*" }, frFR = { "Aucun geste inutile. Un coup net suffit.", "*porte un coup bref et contrôlé.*" } },
    BATTLE_SHOUT = { deDE = { "Wir stehen nicht hier, weil wir keine Angst haben. Sondern trotz ihr.", "*hebt die Waffe, bis das Echo den Ruf zurückträgt.*" }, enUS = { "We stand here not without fear, but in spite of it.", "*raises a weapon until the echo returns the cry.*" }, frFR = { "Nous sommes ici non sans peur, mais malgré elle.", "*lève son arme jusqu'à ce que l'écho réponde au cri.*" } },
    AFTER_BATTLE = { deDE = { "Man zählt die Siege leicht. Die fehlenden Stimmen schwerer.", "*blickt über das Feld und senkt langsam die Waffe.*" }, enUS = { "Victories are easy to count. Missing voices are not.", "*looks across the field and slowly lowers the weapon.*" }, frFR = { "On compte facilement les victoires, moins les voix absentes.", "*observe le champ et baisse lentement son arme.*" } },
    DEFENSIVE_STANCE = { deDE = { "Standhalten heißt nicht, unbeweglich zu sein.", "*wechselt den Stand und lässt den Gegner den ersten Fehler machen.*" }, enUS = { "Holding ground does not mean standing motionless.", "*changes stance and waits for the opponent's first mistake.*" }, frFR = { "Tenir bon ne signifie pas rester immobile.", "*change de posture et attend la première erreur adverse.*" } },
}
for key, translations in pairs(entries) do
    for _, language in ipairs({"deDE","enUS","frFR"}) do
        local locale = addon.localeData and addon.localeData[language]
        local source = locale and locale.texts and locale.texts[key]
        local pool = source and source.gruppe
        if type(pool) == "table" then
            for _, line in ipairs(translations[language]) do
                local exists = false
                for _, previous in ipairs(pool) do
                    if previous == line then exists = true; break end
                end
                if not exists then pool[#pool+1] = line end
            end
        end
    end
end
