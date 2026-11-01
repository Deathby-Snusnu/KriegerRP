# Changelog

Alle Angaben beziehen sich auf Quellstände. Ein Merge, ein Installer-Build
und eine erfolgreiche WoW-Ingame-Prüfung werden **nicht** vorausgesetzt.

## 0.1.1 (unveröffentlicht: Kriegerstimmen statt Kampflog)

### Kreative Textsammlungen
- **Alle 43 Fähigkeitskataloge in Deutsch, Englisch und Französisch neu geschrieben**:
  vier situative Grundvarianten pro Fähigkeit (je zwei Dialoge, zwei
  `/me`-Emotes). Für 22 Feindfähigkeiten kommen jeweils zwei gezielte
  Varianten mit korrekt geschütztem `%s` hinzu.
- **Alle zehn Rassenpools** in jeder Sprache von Fähigkeitsansagen und
  austauschbaren Satzschablonen auf vier rollenspieltypische
  Varianten je Rasse/Fähigkeit umgestellt; inklusive 40 besonderer
  Signatursätze pro Sprachversion für hervorgehobene Fähigkeiten.
- **Ambient-Sammlungen vollständig neu formuliert**, acht
  Varianten für jedes der zehn Völker plus neutrale Stimme.
- Pro Sprachversion damit 2.024 wählbare RP-Texte,
  insgesamt **6.072 Dialog- und Emote-Varianten**. Metadaten
  und die Namen der Fähigkeiten sind nicht mitgezählt.
- Bewusst verschiedene Grundhaltungen: Zwergenhumor,
  gnomische Versuchsfreude, orkische Ehre, taurischer
  Schutzgedanke, untoter Sarkasmus und weitere Volksstimmen.

### Qualität und Kompatibilität
- /say und /me je Textpool ausgewogen, Markierung `*...` für /me.
- `%s` nur für 22 ausdrücklich feindbezogene Ziel-Pools;
  keine Zielnamen in allgemeinen, volkstypischen oder Ambient-Texten.
- Alle ausgegebenen Texte nach UTF-8-Bytelänge geprüft,
  keine über 255 Bytes, keine mehrfachen Fülltext-Zeilen.
- Fähigkeitsschlüssel, Slashtags, SavedVariables, Klassenbegrenzung,
  Chatausgabe und Ambient-System technisch beibehalten.
- Neue Tests `tests/test_creative_voice_catalog.py`
  und `TEXTSTYLE.md` für künftige RPTextStudio-Erweiterungen.
- Die sichtbare AddOn-Versionskennung auf `0.1.1` angehoben.

Ein vollständiger automatischer Testlauf und ein WoW-Ingame-Test
der erweiterten Inhalte sind vor einem Release noch erforderlich.

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
