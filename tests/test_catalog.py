"""Static checks for complete translated warrior texts and split licenses."""
import re
import unittest
from collections import Counter
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
LOCALES = ("deDE", "enUS", "frFR")
KEY = re.compile(r'^    ([A-Z][A-Z0-9_]+) = \{ name = ', re.M)
RACE = re.compile(r'^    ([A-Z][A-Z0-9_]+) = \{$', re.M)
RACE_KEY = re.compile(r'^        ([A-Z][A-Z0-9_]+) = \{ ', re.M)
QUOTED = re.compile(r'"(?:\\.|[^"\\])*"')
EXPECTED = set((
    "BATTLE_STANCE HEROIC_STRIKE CHARGE REND THUNDER_CLAP HAMSTRING "
    "OVERPOWER TACTICAL_MASTERY MOCKING_BLOW RETALIATION VICTORY_RUSH "
    "MORTAL_STRIKE SPEARING_STRIKE SWEEPING_STRIKES BATTLE_SHOUT "
    "DEMORALIZING_SHOUT CLEAVE SLAM INTIMIDATING_SHOUT EXECUTE "
    "CHALLENGING_SHOUT BERSERKER_RAGE BERSERKER_STANCE INTERCEPT "
    "WHIRLWIND PUMMEL BLOODTHIRST RECKLESSNESS PIERCING_HOWL "
    "DEATH_WISH BLOODRAGE DEFENSIVE_STANCE SUNDER_ARMOR TAUNT "
    "SHIELD_BASH REVENGE SHIELD_BLOCK DISARM SHIELD_WALL "
    "SHIELD_SLAM LAST_STAND CONCUSSION_BLOW DEVASTATE"
).split())

class WarriorCatalogChecks(unittest.TestCase):
    def test_toc_and_runtime_files(self):
        toc = (ROOT / "KriegerRP.toc").read_text(encoding="utf-8")
        for line in toc.splitlines():
            line = line.strip()
            if line and not line.startswith("#"):
                self.assertTrue((ROOT / line.replace("\\", "/")).is_file(), line)
        self.assertIn("core\\Cooldown.lua", toc)
        self.assertIn("## OptionalDeps: RPChatMod", toc)

    def test_all_spells_and_races_covered(self):
        self.assertEqual(len(EXPECTED), 43)
        for lang in LOCALES:
            with self.subTest(locale=lang):
                base = ROOT / "locales" / lang
                text = (base / "Texts.lua").read_text(encoding="utf-8")
                racial = (base / "Racial.lua").read_text(encoding="utf-8")
                ambient = (base / "Ambient.lua").read_text(encoding="utf-8")
                keys = KEY.findall(text)
                self.assertEqual(len(keys), 43)
                self.assertEqual(set(keys), EXPECTED)
                races = RACE.findall(racial)
                self.assertEqual(len(races), 10)
                self.assertEqual(len(set(races)), 10)
                counts = Counter(RACE_KEY.findall(racial))
                self.assertEqual(counts, Counter({name: 10 for name in EXPECTED}))
                self.assertIn("NEUTRAL = {", ambient)
                for race in races:
                    self.assertIn(race + " = {", ambient)
                for line in text.splitlines():
                    if not line.lstrip().startswith(tuple(EXPECTED)):
                        continue
                    if " gruppe = {" in line:
                        group = line.split(" gruppe = {", 1)[1]
                        self.assertNotIn("%s", group, lang)
                        self.assertGreaterEqual(len(QUOTED.findall(group)), 3)
                for phrase in (
                    "Ihr werdet diese Formel noch kennenlernen",
                    "Ihr werdet noch von dieser Formel hören",
                ):
                    self.assertNotIn(phrase, text)

    def test_timer_never_sends_chat(self):
        ambient = (ROOT / "core" / "Ambient.lua").read_text(encoding="utf-8")
        self.assertIn("function addon.QueueAmbient()", ambient)
        self.assertIn("function addon.FlushPendingAmbient()", ambient)
        self.assertIn("function addon.ResetAmbientTimer()", ambient)
        timer = ambient.split("C_Timer.After(delay, function()", 1)[1]
        self.assertIn("addon.QueueAmbient()", timer)
        self.assertNotIn("SendChatMessage", timer)
        self.assertNotIn("addon.SendText(", timer)
        main = (ROOT / "KriegerRP.lua").read_text(encoding="utf-8")
        self.assertLess(main.index("FlushPendingAmbient()"), main.index("addon.BuildText(key:upper())"))

    def test_split_licenses_and_docs(self):
        self.assertEqual(
            (ROOT / "LICENSE").read_bytes(),
            (ROOT / "LICENSE-CODE").read_bytes(),
        )
        for path in ("README.md", "CHANGELOG.md", "AMBIENT.md",
                     "LICENSE-CODE", "LICENSE-TEXTS", "LICENSING.md", "NOTICE"):
            self.assertTrue((ROOT / path).is_file(), path)
        for lang in LOCALES:
            for name in ("Texts.lua", "Racial.lua", "Ambient.lua"):
                source = (ROOT / "locales" / lang / name).read_text(encoding="utf-8")
                self.assertTrue(source.startswith("-- SPDX-License-Identifier: CC-BY-SA-4.0"))
        for name in ("KriegerRP.lua", "core/Ambient.lua", "core/Chat.lua",
                     "core/Commands.lua", "core/Cooldown.lua", "core/Text.lua"):
            source = (ROOT / name).read_text(encoding="utf-8")
            self.assertTrue(source.startswith("-- SPDX-License-Identifier: MPL-2.0"))

if __name__ == "__main__":
    unittest.main()
