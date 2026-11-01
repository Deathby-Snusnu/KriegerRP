# Textstil und Redaktionsregeln für KriegerRP

Dieses Dokument beschreibt die kreativen Textsammlungen in den Sprachen
`deDE`, `enUS` und `frFR`, besonders für die Pflege mit RPTextStudio.

## Schreiben wie ein Krieger, nicht wie ein Kampflog

Nicht:
> „Ich führe Heldenhafter Stoß aus.“

Besser:
> „Wisst Ihr, warum meine Waffe so schwer ist? Sie widerspricht selten.“

Und als Handlung:
> *verlegt das Gewicht auf den vorderen Fuß und führt einen wuchtigen Hieb.*

In der Datei lautet die Emote-Zeile inklusive Markierung:
`"*verlegt das Gewicht auf den vorderen Fuß und führt einen wuchtigen Hieb.*"`.
Das AddOn entfernt die äußeren Sternchen und sendet einen `EMOTE`-Chat.

Jede Fähigkeit soll zur *Situation* passen: beim `CHARGE` der
übermütige Aufbruch, beim `SHIELD_BLOCK` stoische Abwehr, beim
`TAUNT` spöttische Herausforderung, bei `LAST_STAND` das
Schutzversprechen. Allgemeine Zeilen ohne Bezug zur Fähigkeit
gelten als Fülltexte.

## Rassenstimmen

Die kulturelle Stimme ist ein eigenes Verhalten, kein eingesetzter
Fähigkeitsname. Es gibt zehn Profile:

| Volk | Motive, ohne jedes Mal dieselbe Floskel |
| --- | --- |
| Gnom | übergenaue Messungen, ausgefallene Konstruktionen, kontrolliertes Chaos |
| Mensch | Ausbildung, Kameradschaft, Pflicht und Verantwortung |
| Zwerg | Bart, Amboss, Bergfestungen, Bier und trockener Spott |
| Nachtelf | uralte Erinnerungen, Wälder, Stille und Balance |
| Draenei | verlorene Heimat, beharrlicher Schutz, Hoffnung |
| Orc | Clan, Ehre, Ahnen und bewusst gezügelter Zorn |
| Troll | Loa, Ahnen, Trommeln, schelmisches Lachen |
| Tauren | Erdenmutter, Ebene, Herde und Schutz der Schwächeren |
| Untoter | knochentrockener Humor, alte Verletzungen, zweite Chancen |
| Blutelf | Formgefühl, kontrollierte Klinge, feine Ironie und Stolz |

Pro Rasse/Fähigkeit stehen **zwei gesprochene** und **zwei Emote-Zeilen**
zur Verfügung. Für zentrale Fähigkeiten gibt es eigene, nicht aus
dem Fähigkeitsnamen zusammengesetzte Signatursätze.

## Technische Regeln

- Behalte alle 43 bestehenden Schlüssel in allen drei Sprachen unverändert.
- In `locales/<sprache>/Texts.lua` gibt es `ziel` (nur gerichtete
  Angriffe gegen feindliche Einheiten) und `gruppe` (ohne Ziel).
- `%s` darf **nur in `ziel`** vorkommen, und nur bei einer
  Fähigkeit aus der Whitelist in `core/Text.lua`.
- Rassen- und Ambient-Zeilen nennen **niemals** ein zufällig gewähltes Ziel.
- Eine Zeile sollte mindestens eine erkennbare Handlung, Haltung,
  Beobachtung oder charakteristische Pointe enthalten.
- Ohne das umschließende `*...` wird gesprochen, mit Sternchen
  entsteht ein `/me`-Emote.
- Die komplette Chatnachricht muss unter **256 UTF-8-Bytes** bleiben.
  `|`, Zeilenumbrüche und unausgeglichene Sternchen sind unzulässig.
- Kein Text darf einen bestätigten Treffer, Schaden oder erfolgreichen
  Zauber vortäuschen. Makros lösen RP-Text aus, keine Erfolgserkennung.
- `TACTICAL_MASTERY` und `DEVASTATE` bleiben rein erzählerische
  Schlüssel und sind keine automatisch wirkbaren `/cast`-Fähigkeiten.
- Bei neuen Texten deutsche, englische und französische Inhalte
  gemeinsam ergänzen; eine bloße Maschinenübersetzung ohne Prüfung
  reicht für kulturspezifische Wortspiele nicht aus.
- Die Textdateien bleiben **CC BY-SA 4.0**, Programmcode und Tests
  bleiben **MPL-2.0**. Siehe `LICENSING.md` und `NOTICE`.

## Qualität prüfen

```powershell
python -m unittest discover -s tests -p "test_*.py"
lua tests/test_runtime.lua
```

Der Python-Test prüft unter anderem Schlüssel- und Rassenabdeckung,
Textvielfalt, Markierungen, sichere Zielplatzhalter und die
UTF-8-Bytelänge. Der Lua-Smoke-Test prüft zusätzlich
Laufzeitverhalten wie Ambient, Cooldown, Makroaufrufe und Chatkanäle.

Wurde ein Katalog mit RPTextStudio geändert, müssen beide Prüfungen
erneut laufen. Anschließend sollte im WoW-Client ein Krieger
mit `/krp list all` und verschiedenen Fähigkeiten getestet werden.
