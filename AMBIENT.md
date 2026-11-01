# Ambient-System in KriegerRP

KriegerRP benutzt dasselbe **Vormerkungsprinzip** wie JaegerRP, PaladinRP,
DruidenRP und HexerRP. Ein Timer darf einen Ambient-Text **nicht direkt** an
WoWs Chat-API senden.

## Ablauf

1. Nach dem Login oder einer Einstellungsänderung startet ein Timer mit
   zufälliger Verzögerung zwischen `ambientMinInterval` und `ambientMaxInterval`.
2. Bei Ablauf prüft `QueueAmbient()` die aktivierte Automatik,
   Kriegerklasse, Kampffreigabe und `ambientChance`. Ein Treffer setzt
   ausschließlich `pending = true`, ohne Chattext zu verschicken.
3. Der nächste ausdrücklich ausgelöste `/krp <SCHLÜSSEL>`-Aufruf prüft
   `FlushPendingAmbient()`. Bei erfüllten Bedingungen wird **ein**
   Ambient-Text statt des Fähigkeitstextes ausgegeben und der Cooldown
   gestartet. Ist noch kein Text fällig, gilt die normale
   Fähigkeitstext-Wahrscheinlichkeit.
4. `ResetAmbientTimer()` verwirft wartende Ereignisse und macht veraltete
   Timer-Callbacks durch einen Generationenzähler unwirksam.

Ein `/krp ambient` oder `/krp ambient test` ist ein **manueller**
spielerinitiierter Test, auch bei deaktivierter Automatik. Dabei gelten
Kriegerklasse, Kampffreigabe, Textchance und Cooldown.

## Standardeinstellungen für neue Charaktere

| Variable | Vorgabe |
| --- | --- |
| `ambientEnabled` | `true` |
| `ambientInCombat` | `false` |
| `ambientChance` | `70` |
| `ambientMinInterval` | `180` Sekunden |
| `ambientMaxInterval` | `420` Sekunden |
| `textChance` | `30` |
| `cooldown` | `20` Sekunden |

Die neue Konfiguration überschreibt keine gültigen
`KriegerRP_CharacterDB`-Einstellungen eines bestehenden Charakters.

## Steuerung

- `/krp ambient on` und `/krp ambient off`: Vormerkung ein/aus.
- `/krp ambient test`: manueller Textversuch.
- `/krp ambient status`: aktuelle Einstellungen.
- `/krp ambient chance 70`: Timer-Trefferwahrscheinlichkeit.
- `/krp ambient combat on`: Ambient auch im Kampf erlauben.
- `/krp ambient interval 180 420`: Zeitfenster in Sekunden.
- Die **Ambient-Seite von RPControlCenter** kann dieselben DB-Felder
  ändern und den Timer über `ResetAmbientTimer()` zurücksetzen.

Technische Tests: `lua tests/test_runtime.lua`. Änderungen und Lizenz:
[CHANGELOG.md](CHANGELOG.md), [LICENSING.md](LICENSING.md).
