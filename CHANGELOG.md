# Changelog

Alle Angaben beziehen sich auf Quellstände. Ein Merge, ein Installer-Build
und eine erfolgreiche WoW-Ingame-Prüfung werden **nicht** vorausgesetzt.

## 0.1.0 (Entwicklungsstand, noch unveröffentlicht)

### Hinzugefügt
- Eigenständiges KriegerRP-AddOn mit `/krp` und `/kriegerrp`.
- 43 RP-Schlüssel (42 Einträge des geprüften Forever-Beta-Zauberbuchs plus
  `DEVASTATE` als zusätzlichen Erzähltext).
- Übersetzte Fähigkeits- und Ambient-Textpools in deDE, enUS und frFR.
- Für zehn Völker jeweils 43 Fähigkeitspools und geschlechtsneutrale Texte.
- Differenzierung zwischen gezielten Feindfähigkeiten, Selbstfähigkeiten,
  Haltungen, Schreien und Flächenangriffen.
- Gemeinsame SAY/YELL-Sprachentscheidung über optionales RPChatMod,
  sichere EMOTE-Ausgabe und konfigurierbarer Gruppenkanal.
- `/krp list [racial|all]`, Status, Debug, Ambient-Verwaltung und
  individuelle Einstellung pro Charakter.
- Queue-basiertes Ambient mit `QueueAmbient`, `FlushPendingAmbient`,
  `ResetAmbientTimer` und separater Cooldown-API.
- Lua-Smoke-Tests und statische Katalog-/Lizenzprüfungen.

### Geändert
- Textchance von 100 % auf 30 % und Cooldown von 0 auf 20 Sekunden für
  **neue Charaktere** angeglichen. Bereits gespeicherte Werte bleiben erhalten.
- Ambient-Chance 70 %, Intervalle 180 bis 420 Sekunden und standardmäßig
  aktivierte Vormerkung. Ambient im Kampf bleibt standardmäßig gesperrt.
- Wiederholte allgemeine Kampf-Füllsätze in den drei Textsprachen durch
  individuelle Fähigkeitsformulierungen und Emotes ersetzt.
- Ambient-Timer versenden **keinen Chat** mehr; Texte gehen nur auf
  spielerausgelöste RP-Aktionen hin heraus.
- `/krp list all` verwendet kompakte Quellenkennzeichen, damit Chatzeilen
  nicht unnötig lang werden.

### Hinweise
- Eine RP-Makrozeile beweist keinen erfolgreichen Fähigkeitseinsatz.
- Passiver `TACTICAL_MASTERY`-Schlüssel ist nur erzählerisch abrufbar.
- `DEVASTATE` ist hier kein bestätigter eigenständig wirkbarer Zauber.
- Classic+/Forever-APIs, Ingame-Verhalten und Testläufe sind noch zu prüfen.
