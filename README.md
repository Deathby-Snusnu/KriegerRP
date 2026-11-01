# KriegerRP 0.1.0

Ein eigenständiges, mehrsprachiges WoW-RP-AddOn für Kriegerinnen und Krieger. Die Sprache ist **geschlechtsneutral**, die Anrede und Tonlage richten sich nach Volk und Fähigkeit. Vorgesehen sind Classic-/Forever-nahe Fähigkeitsschlüssel; ob sie im verwendeten Client verfügbar sind, muss im Spiel geprüft werden.

**Start:** `/krp help` oder `/kriegerrp help`. `/krp list` zeigt alle 37 Schlüssel.

**Beispiele:** `/krp CHARGE`, `/krp BATTLE_SHOUT`, `/krp SHIELD_BLOCK`, `/krp EXECUTE`, `/krp AMBIENT`.

**Ambient:** `/krp ambient` probiert manuell einen volkstypischen Text. Automatische Ambient-Ausgaben sind zunächst **deaktiviert** und können im RPControlCenter bei installiertem KriegerRP aktiviert werden. Standardintervall: 120–300 Sekunden, mit Chance und optionaler Kampf-Sperre.\n\n**Einstellungen:** `/krp chance 35`, `/krp cooldown 5`, `/krp racial 60`, `/krp language deDE`, `/krp channel AUTO`, `/krp status`.

**Makro-Beispiel:**

```text
#showtooltip Sturmangriff
/cast Sturmangriff
/krp CHARGE
```

Die AddOn-Ausgabe bestätigt **keinen tatsächlich erfolgreichen Zauber oder Angriff**. Sie reagiert auf den expliziten Makro-Aufruf. Kampftexte werden nach Chance/Cooldown still unterdrückt. Texte mit `*...` laufen über den Emote-Chat; normale Texte über den konfigurierten Kanal. Zielnamen werden nur bei explizit zielgerichteten Angriffs- und Spott-Schlüsseln eingesetzt, nicht für defensive Fähigkeiten, Schreie und Flächenangriffe.

## Sprachen und Völker

Alle 37 Fähigkeitsschlüssel sind in **deDE, enUS, frFR** vorhanden. Die Volkstexte unterstützen **Gnome, Menschen, Zwerge, Nachtelfen, Draenei, Orcs, Trolle, Tauren, Untote und Blutelfen**. Nicht erkannte Völker erhalten allgemeine Fähigkeitstexte und neutrale Ambient-Formulierungen. `/krp racial 40` ist die Chance auf volkstypische Texte.

## Installation

`KriegerRP.toc` muss direkt unter `Interface/AddOns/KriegerRP/` liegen. RPChatMod ist optional; wenn es geladen ist, übernimmt KriegerRP für SAY/YELL dessen Sprachpolitik (Volkssprache, Gruppensprache). Die `## Interface: 16001`-Zeile ist nur Metadaten und gegebenenfalls an den tatsächlich getesteten Client anzupassen.

Die Weiterentwicklung erfolgt im **eigenen Repository** `Deathby-Snusnu/KriegerRP`. Das Sammelrepository `RPAddOns` bindet KriegerRP als Git-Submodul ein. RPTextStudio kann es nach Übernahme des Katalog-PR #44 direkt von GitHub laden, sobald diese Erstversion in `main` gemergt ist. Die Sammlung kann es weiterhin als Submodul paketieren und installieren.

## Lizenz

Laufzeitcode: MPL-2.0. Kreative Textpools: CC BY-SA 4.0, siehe die Lizenzunterlagen des Sammelrepositories.
