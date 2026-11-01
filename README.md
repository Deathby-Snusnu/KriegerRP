# KriegerRP 0.1.0

Ein eigenständiges, mehrsprachiges WoW-RP-AddOn für Kriegerinnen und Krieger. Die Sprache ist **geschlechtsneutral**, die Anrede und Tonlage richten sich nach Volk und Fähigkeit. Vorgesehen sind Classic-/Forever-nahe Fähigkeitsschlüssel; ob sie im verwendeten Client verfügbar sind, muss im Spiel geprüft werden.

**Start:** `/krp help` oder `/kriegerrp help`. `/krp list` zeigt alle 43 Schlüssel.

**Beispiele:** `/krp CHARGE`, `/krp BATTLE_SHOUT`, `/krp SHIELD_BLOCK`, `/krp EXECUTE`, `/krp AMBIENT`.

**Ambient:** `/krp ambient` probiert manuell einen volkstypischen Text. Automatische Ambient-Ausgaben sind zunächst **deaktiviert** und können im RPControlCenter bei installiertem KriegerRP aktiviert werden. Standardintervall: 120–300 Sekunden, mit Chance und optionaler Kampf-Sperre.

**Einstellungen:** `/krp chance 35`, `/krp cooldown 5`, `/krp racial 60`, `/krp language deDE`, `/krp channel AUTO`, `/krp status`.

**Makro-Beispiel:**

```text
#showtooltip Sturmangriff
/cast Sturmangriff
/krp CHARGE
```

Die AddOn-Ausgabe bestätigt **keinen tatsächlich erfolgreichen Zauber oder Angriff**. Sie reagiert auf den expliziten Makro-Aufruf. Kampftexte werden nach Chance/Cooldown still unterdrückt. Texte mit `*...` laufen über den Emote-Chat; normale Texte über den konfigurierten Kanal. Zielnamen werden nur bei explizit zielgerichteten Angriffs- und Spott-Schlüsseln eingesetzt, nicht für defensive Fähigkeiten, Schreie und Flächenangriffe.

## Vollständigkeit des Forever-Zauberbuchs

Abgleich mit dem Krieger-Zauberbuch des Forever-Beta-Clients **1.60.1.70707**
(Stand 30. Oktober 2026): Alle **42** dort gelisteten Klassenfähigkeiten sind
als RP-Schlüssel erfasst, einschließlich Kampfhaltung, Verteidigungshaltung,
Berserkerhaltung, Durchdringendem Heulen, Aufspießendem Stoß und Taktiker.

`TACTICAL_MASTERY` (**Taktiker**) ist eine **passive** Fähigkeit und darf
nicht mit `/cast` als aktiver Zauber in einem Makro verwendet werden.
`/krp TACTICAL_MASTERY` ist ein rein erzählerischer, freiwilliger Textaufruf.
`DEVASTATE` ist ein **zusätzlicher** RP-Schlüssel für einen in den Clientdaten
enthaltenen Auslöseeffekt von `SUNDER_ARMOR`, jedoch keine bestätigte
eigenständige aktive Fähigkeit im 42er-Zauberbuch. Ein `/cast Verwüsten`-Makro
ist deshalb nicht pauschal gültig.

Nicht abgedeckt sind sämtliche passiven Talent- und Waffenboni, automatische
Procs sowie nicht zur 42er-Zauberbuchliste gehörende Saison-/Beta-IDs. Diese
sind keine eigenständig nutzbaren Aktionsknöpfe. Die Verfügbarkeit einzelner
Fähigkeiten hängt von Talentwahl, Level und WoW-Client ab.

Quelle: https://foreverchanges.pro/spellbook/warrior

## Sprachen und Völker

Alle 43 RP-Schlüssel sind in **deDE, enUS, frFR** vorhanden. Die Volkstexte unterstützen **Gnome, Menschen, Zwerge, Nachtelfen, Draenei, Orcs, Trolle, Tauren, Untote und Blutelfen**. Nicht erkannte Völker erhalten allgemeine Fähigkeitstexte und neutrale Ambient-Formulierungen. `/krp racial 40` ist die Chance auf volkstypische Texte.

## Installation

`KriegerRP.toc` muss direkt unter `Interface/AddOns/KriegerRP/` liegen. RPChatMod ist optional; wenn es geladen ist, übernimmt KriegerRP für SAY/YELL dessen Sprachpolitik (Volkssprache, Gruppensprache). Die `## Interface: 16001`-Zeile ist nur Metadaten und gegebenenfalls an den tatsächlich getesteten Client anzupassen.

Die Weiterentwicklung erfolgt im **eigenen Repository** `Deathby-Snusnu/KriegerRP`. Das Sammelrepository `RPAddOns` bindet KriegerRP als Git-Submodul ein. RPTextStudio kann es nach Übernahme des Katalog-PR #44 direkt von GitHub laden, sobald diese Erstversion in `main` gemergt ist. Die Sammlung kann es weiterhin als Submodul paketieren und installieren.

## Lizenz

Laufzeitcode: MPL-2.0. Kreative Textpools: CC BY-SA 4.0, siehe die Lizenzunterlagen des Sammelrepositories.
