"""Static creative-voice contracts for the 3 supported KriegerRP locales.

Run: python -m unittest discover -s tests -p "test_*.py"
"""
import json
import re
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
LOCALES = ("deDE", "enUS", "frFR")
ENTRY = re.compile(r'^    ([A-Z][A-Z0-9_]+) = \{ name = ("(?:\\.|[^"\\])*"), ziel = \{ (.*?) \}, gruppe = \{ (.*?) \} \},?$', re.M)
RACE_HEADER = re.compile(r'^    ([A-Z][A-Z0-9_]+) = \{$', re.M)
RACIAL_ENTRY = re.compile(r'^        ([A-Z][A-Z0-9_]+) = \{ (.*?) \},?$', re.M)
AMBIENT_ENTRY = re.compile(r'^    ([A-Z][A-Z0-9_]+) = \{ (.*?) \},?$', re.M)
STRINGS = re.compile(r'"(?:\\.|[^"\\])*"')
RACES = {"GNOME", "HUMAN", "DWARF", "NIGHTELF", "DRAENEI", "ORC",
         "TROLL", "TAUREN", "UNDEAD", "BLOODELF"}


def parse_strings(source: str) -> list[str]:
    """Lua string pools are intentionally encoded as JSON-compatible strings."""
    return [json.loads(m.group()) for m in STRINGS.finditer(source)]


def check_chat_line(line: str) -> None:
    """Keep the same safety contract as core/Chat.lua (bytes, emotes, chat escapes)."""
    assert isinstance(line, str) and line.strip(), "empty text"
    assert len(line.encode("utf-8")) <= 255, "overlong WoW chat line"
    assert ("\r" not in line and "\n" not in line and "|" not in line)
    assert line.startswith("*") == line.endswith("*"), "unbalanced /me marker"
    if line.startswith("*"):
        assert line.count("*") == 2, "unexpected nested emote marker"


class WarriorCreativeVoicesTests(unittest.TestCase):
    def test_originality_and_target_pools(self):
        classes = None
        target_code = (ROOT / "core" / "Text.lua").read_text(encoding="utf-8")
        target_section = target_code.split("local targeted = {", 1)[1].split("}", 1)[0]
        targeted = set(re.findall(r'([A-Z][A-Z0-9_]+)=true', target_section))
        self.assertEqual(len(targeted), 22)
        for lang in LOCALES:
            with self.subTest(locale=lang):
                source = (ROOT / "locales" / lang / "Texts.lua").read_text(encoding="utf-8")
                entries = ENTRY.findall(source)
                self.assertEqual(len(entries), 43)
                keys = {key for key, *_ in entries}
                if classes is None:
                    classes = keys
                self.assertEqual(keys, classes)
                self.assertEqual(len(keys), 43)
                for key, quoted_name, target, group in entries:
                    name = json.loads(quoted_name)
                    normal = parse_strings(group)
                    directed = parse_strings(target)
                    self.assertEqual(len(normal), 4, key)
                    self.assertEqual(sum(x.startswith("*") for x in normal), 2)
                    self.assertEqual(len(set(normal)), len(normal))
                    for text in normal:
                        check_chat_line(text)
                        self.assertNotIn("%s", text)
                        # The actual localized ability name is metadata, not a spoken /me announcement.
                        if len(name) >= 8:
                            self.assertNotIn(name.casefold(), text.casefold())
                    if key in targeted:
                        self.assertEqual(len(directed), 2, key)
                        self.assertTrue(all("%s" in x for x in directed), key)
                    else:
                        self.assertEqual(directed, [], key)
                    for text in directed:
                        check_chat_line(text)

    def test_race_specific_voice_and_ambient_variety(self):
        for lang in LOCALES:
            with self.subTest(locale=lang):
                base = ROOT / "locales" / lang
                racial = (base / "Racial.lua").read_text(encoding="utf-8")
                ambient = (base / "Ambient.lua").read_text(encoding="utf-8")
                names = RACE_HEADER.findall(racial)
                self.assertEqual(set(names), RACES)
                self.assertEqual(len(names), 10)
                entries = RACIAL_ENTRY.findall(racial)
                self.assertEqual(len(entries), 430)
                seen = set()
                for key, values in entries:
                    lines = parse_strings(values)
                    self.assertEqual(len(lines), 4, key)
                    self.assertEqual(sum(t.startswith("*") for t in lines), 2)
                    for t in lines:
                        check_chat_line(t)
                        self.assertNotIn("%s", t, "non-targeted racial pool")
                        self.assertNotIn(t, seen, "template reused across race/ability")
                        seen.add(t)
                entries = AMBIENT_ENTRY.findall(ambient)
                self.assertEqual(len(entries), 11)
                self.assertEqual({key for key, _ in entries}, RACES | {"NEUTRAL"})
                for race, values in entries:
                    lines = parse_strings(values)
                    self.assertEqual(len(lines), 8, race)
                    self.assertEqual(sum(t.startswith("*") for t in lines), 4)
                    for line in lines:
                        check_chat_line(line)
                        self.assertNotIn("%s", line)
                        self.assertNotIn(line, seen)
                        seen.add(line)

    def test_chat_runtime_unchanged(self):
        chat = (ROOT / "core" / "Chat.lua").read_text(encoding="utf-8")
        self.assertIn('destination = emote and "EMOTE" or channel()', chat)
        self.assertIn('rpChat.GetChatLanguageID(destination)', chat)
        self.assertIn('#text > 255', chat)
        runtime = (ROOT / "KriegerRP.lua").read_text(encoding="utf-8")
        self.assertIn('addon.FlushPendingAmbient(chancePassed)', runtime)

if __name__ == "__main__":
    unittest.main()
