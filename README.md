# KriegerRP 0.1.2 (Textausbau)

## Neue freie RP-Aktionen (0.1.2)

Diese sechs manuellen Textaktionen ergänzen das bestehende Zauberbuch,
stehen aber **nicht für trainierbare WoW-Fähigkeiten**:
- `ARMOR_CHECK`
- `WEAPON_DRILL`
- `FORMATION`
- `BATTLEFIELD_AID`
- `BANNER_OATH`
- `AFTER_BATTLE`

Jeder Schlüssel hat eigenständige gesprochene Texte und /me-Handlungen
in Deutsch, Englisch und Französisch. Alte RP-Makros, persönliche
Texte und gespeicherte Einstellungen bleiben unverändert.


**KriegerRP** ist das eigenständige Klassen-RP-AddOn für Kriegerinnen und Krieger
im WoW-Classic+/Forever-Umfeld. Es liefert Fähigkeits- und Ambient-Texte,
volkstypische Sprechweisen, `/say` und `/me`-Emotes sowie die
gemeinsame Volkssprache von RPChatMod, sofern RPChatMod installiert ist.

**Status:** Die Erstversion ist auf `main`; die kreative Textüberarbeitung
wird in einem separaten Pull Request vorbereitet. Ein vollständiger
WoW-Forever-Ingame-Test der neuen Textsammlungen steht noch aus.

## Installation

Den Ordner `KriegerRP` direkt nach
`<WoW>/Interface/AddOns/KriegerRP/` installieren. Die Datei
`KriegerRP.toc` muss unmittelbar darin liegen. Die
`## Interface: 16001`-Angabe entspricht dem vorgesehenen Forever-Profil;
eine TOC-Anpassung allein beweist keine API-Kompatibilität.

Alternativ kann [RPAddOns](https://github.com/Deathby-Snusnu/RPAddOns)
KriegerRP als Git-Submodul paketieren und installieren. RPTextStudio enthält den
GitHub-Katalogeintrag aus dem bereits gemergten
[PR #44](https://github.com/Deathby-Snusnu/RPTextStudio/pull/44).
Installationen und Updates mit RPTextStudio behalten ihren gesonderten,
geschützten Bestätigungs- und Sicherungsablauf.

Nach der Installation das Spiel starten oder bei Änderungen `/reload` nutzen.
Hilfe: `/krp help` oder `/kriegerrp help`.

## Befehle

| Befehl | Wirkung |
| --- | --- |
| `/krp <KEY>` | RP-Text zu einer Kriegerfähigkeit, z. B. `CHARGE`, `SHIELD_BLOCK` |
| `/krp list` | Verfügbare Fähigkeitsschlüssel |
| `/krp list racial` | Schlüssel mit rassespezifischen Texten für die aktuelle Rasse |
| `/krp list all` | Alle Schlüssel und kompakte Herkunftskennzeichen (F = Fähigkeit, V = Völker) |
| `/krp status`, `/krp debug` | Einstellungen bzw. technische Diagnose |
| `/krp chance 0-100`, `/krp cooldown 0-3600` | Textwahrscheinlichkeit und Sekundenabstand |
| `/krp racial 0-100` | Chance auf rassespezifische Texte |
| `/krp language deDE\|enUS\|frFR` | Textsprache |
| `/krp channel SAY\|YELL\|AUTO\|PARTY\|RAID\|INSTANCE_CHAT` | Chatkanal für gesprochene Texte |
| `/krp ambient` bzw. `/krp ambient test` | Manuell Ambient-Text versuchen |
| `/krp ambient on\|off` | Automatische Ambient-Vormerkung aktivieren/deaktivieren |
| `/krp ambient status`, `/krp ambient chance 0-100` | Ambient-Anzeige und Wahrscheinlichkeit |
| `/krp ambient combat on\|off` | Ambient während des Kampfs erlauben/verbieten |
| `/krp ambient interval MIN MAX` | Intervall in Sekunden, jeweils 30 bis 7200 |

Die `/krp`-Befehle erzeugen nur Texte, **keine Fähigkeiten**.
Fähigkeiten werden nicht automatisch erkannt und ein Makro prüft
keinen tatsächlichen Kampferfolg.

### Makrobeispiel

```text
#showtooltip Sturmangriff
/cast Sturmangriff
/krp CHARGE
```

Die RP-Zeile ist optional. `TACTICAL_MASTERY` (**Taktiker**) ist passiv:
`/krp TACTICAL_MASTERY` ist nur Erzähltext, **kein** `/cast`-Zauber.
`DEVASTATE` wird als zusätzlicher RP-Schlüssel geführt, aber nicht als
eigenständige aktive Fähigkeit im geprüften Zauberbuch bestätigt.

## Standardwerte für neue Charaktere

| Option | Standardwert |
| --- | --- |
| Textchance | 30 % |
| Cooldown | 20 Sekunden |
| Rassenspezifische Texte | 40 % |
| Ausgabesprache und Kanal | `deDE` und `SAY` |
| Automatisches Ambient | Aktiviert (nur vormerken, **niemals direkt aus dem Timer senden**) |
| Ambient-Chance | 70 % |
| Ambient-Intervall | 180 bis 420 Sekunden |
| Ambient im Kampf | Deaktiviert |

Bereits gespeicherte Werte in `KriegerRP_CharacterDB` bleiben erhalten,
solange sie gültig sind. Die Zeitsteuerung merkt Ambient nur vor.
Ein fälliger Text wird bei der **nächsten bewusst ausgelösten RP-Aktion**
statt des Fähigkeitstextes ausgegeben, sofern Klasse, Kampf und Cooldown
passen. Damit entstehen keine unbeabsichtigten Chat-Ausgaben allein durch
einen Timer. Der manuelle Ambient-Test funktioniert auch bei deaktivierter
Automatik. Mehr dazu in [AMBIENT.md](AMBIENT.md).

## Neue Sprechstimmen und kreative Texte

KriegerRP spricht **nicht wie ein Kampflog**: der Name der gewirkten
Fähigkeit steht nur als Metadatum in den Katalogen. Die ausgewählten Zeilen
sind Dialoge, Provokationen, Schutzversprechen, situative Beobachtungen oder
Handlungen. `*...`-Einträge werden als `/me` ausgegeben; andere als
`/say` beziehungsweise über den eingestellten Kanal.

Die Version 0.1.1 enthält in jeder Sprache:
- **43 Fähigkeiten**, jeweils vier allgemeine Textvarianten (2 gesprochen,
  2 Emotes) und zwei feindbezogene Varianten für 22 gerichtete Aktionen
- **10 Rassenstimmen** mit jeweils vier Varianten für jeden Fähigkeitsschlüssel
  (je 2 gesprochen und 2 Emotes)
- **11 Ambient-Pools** mit jeweils acht Varianten, einschließlich
  neutralem Fallback

Das sind **2.024 auswählbare Rollenspieltexte pro Sprache**, zusammen
**6.072** in deDE/enUS/frFR. Titel und Fähigkeitsmetadaten sind dabei
nicht mitgezählt. Die Textauswahl behält den bisherigen Zufallsmechanismus
und die im Control Center einstellbare `racialTextChance` bei.

Auch innerhalb derselben Fähigkeit unterscheiden sich die Völker hörbar.
Ein Gnom spricht von Berechnungen und Experimenten, Zwerge von Bier,
Sturheit und Handwerk, Orcs von Ehre und Clan, Tauren von Erdenmutter
und Schutz, Untote mit trockenem Humor. Neben den spieltypischen
Anspielungen enthalten die Rassenpools besondere, gezielt für einzelne
Fähigkeiten geschriebene Sätze. Ausführliche Stilhinweise:
[TEXTSTYLE.md](TEXTSTYLE.md).

**Beispiel für einen Krieger beim Sturmangriff:**
> „Ich komme! Das ist keine Warnung, sondern eine Wegbeschreibung!“

**Beispiel für einen Zwergen-Krieger beim Schlachtruf:**
> „Wer nach dem Kampf noch steht, kriegt mein letztes Fass. Also fast.“

Die Texte geben **keine Erfolgsmeldung** des tatsächlichen Casts.
Bei `/krp`-Makros werden sie bewusst als Rollenspiel ausgegeben.

## Fähigkeitsabdeckung und Sprachen

Die drei Laufzeitkataloge `deDE`, `enUS` und `frFR` enthalten jeweils
**43 RP-Schlüssel**: die 42 Einträge des verglichenen
Forever-Beta-Kriegerzauberbuchs (Build **1.60.1.70707**,
Stand **30. Oktober 2026**) plus `DEVASTATE` als zusätzlichen
Erzähltext. Die genannte Abdeckung bezieht sich nur auf diesen
Zauberbuchstand, **nicht** auf sämtliche passiven Boni, Proc-IDs und
künftigen Forever-Änderungen.

Quelle: https://foreverchanges.pro/spellbook/warrior

Für jeden Schlüssel gibt es allgemeine, ausdrücklich wirkungsbezogene
Formulierungen und Emotes sowie Texte für zehn Völker: Gnome, Menschen,
Zwerge, Nachtelfen, Draenei, Orcs, Trolle, Tauren, Untote und Blutelfen.
Die Texte sind geschlechtsneutral, sodass sie zu Kriegerinnen und Kriegern
passen. Nicht erkannte Völker erhalten allgemeine Texte und neutrale
Ambient-Formulierungen.

Nur **zielgerichtete Feindfähigkeiten** dürfen den ausgewählten angreifbaren
Gegner in ihren Texten nennen. Haltungen, Schreie, Flächenangriffe und
Selbstfähigkeiten nennen keinen zufällig ausgewählten Charakter.
`%s` wird nur im zulässigen Zielpool verwendet.

## Chat und Zusammenspiel

`*...`-Texte gehen ohne Sternchen als `EMOTE` heraus. Andere Texte
nutzen den eingestellten Chatkanal. Bei `SAY` oder `YELL` wird, sofern
verfügbar, `RPChatMod.GetChatLanguageID(channel)` verwendet.
Im `AUTO`-Modus wird je nach Gruppe / Schlachtzug / Instanz der
geeignete Chatkanal gewählt.

[RPControlCenter PR #6](https://github.com/Deathby-Snusnu/RPControlCenter/pull/6)
ergänzt KriegerRP zur Ingame-Konfiguration. Alle Einstellungen bleiben
**pro Charakter** im eigenen AddOn gespeichert.

## Entwicklung und Tests

- Lua-Test: `lua tests/test_runtime.lua` mit Lua 5.1 oder 5.4.
- Statische Katalogprüfung: `python -m unittest discover -s tests -p "test_*.py"`.
- Manuelle Prüfung: WoW-Login, `/krp list racial`, `/krp ambient on`,
  mehrere Fähigkeiten mit/ohne Ziel, `/say`/`/me` und RPControlCenter.

Das Testgerüst umfasst außerdem kreative Textprüfungen für Länge,
Textvielfalt, `/say`/`/me`-Verhältnis und Zielplatzhalter. Der
vollständige Testlauf und die Ingame-Validierung stehen noch aus. Änderungen:
[CHANGELOG.md](CHANGELOG.md).

## Lizenz und Hinweise

Der **Lua-Programmcode und Tests** stehen unter **MPL-2.0**
([LICENSE-CODE](LICENSE-CODE)). Die **kreativen Texte und Übersetzungen**
stehen unter **CC BY-SA 4.0** ([LICENSE-TEXTS](LICENSE-TEXTS)).
Die Zuordnung ist *nicht* wahlweise und wird in
[LICENSING.md](LICENSING.md) und [NOTICE](NOTICE) dokumentiert.
KriegerRP ist ein unabhängiges Fanprojekt, keine offizielle
Blizzard-Veröffentlichung.
