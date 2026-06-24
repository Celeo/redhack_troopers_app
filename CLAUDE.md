# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project

A Flutter character sheet app for the **Troopers** custom TTRPG system. The source PDF for the character sheet and the full game rules are in `source_material/` (gitignored, kept local).

## Commands

All commands run from the repo root:

```bash
flutter run -d linux          # Run on Linux desktop (fastest iteration)
flutter run                   # Run on connected Android device
flutter analyze               # Lint (must pass clean before any PR)
flutter build linux --debug   # Compile check without running
flutter test                  # Run tests (currently minimal)
```

There is no code generation step — no `build_runner`, no generated files to maintain.

## Architecture

**State:** A single `Character` object owned by a Riverpod `StateNotifier` (`CharacterNotifier` in `lib/providers/character_provider.dart`). All UI reads from `characterProvider` and mutates via `notifier.update((c) => c.copyWith(...))`. State is persisted synchronously to `SharedPreferences` on every update, keyed as `character_v1`.

**Bootstrap:** `main()` loads `SharedPreferences` before `runApp`, then injects it via a `ProviderScope` override of `sharedPreferencesProvider`. This keeps the initial character load synchronous — there is no async loading state.

**Models:** Plain immutable Dart classes in `lib/models/`, each with `copyWith`, `toJson`, and `fromJson`. No code generation. `Character` composes all other models. `Character.attrMod(String attr)` returns the modifier for a given attribute key (`'BODY'`, `'AGIL'`, `'MIND'`, `'PRES'`, `'LUCK'`) — used by the skills tab to compute totals.

**UI structure:**
- `CharacterSheetScreen` — 4-tab scaffold; AppBar title reflects character name
- `StatsTab` — identity fields, attributes table (score/current/mod/sv), HP counters
- `SkillsTab` — 15 fixed skills with auto-computed totals, 7 training slots
- `CombatTab` — armor, 3 weapons with ammo trackers, psionics (Usage Dice), vehicle
- `GearTab` — dynamic gear list (add/remove), 7 fixed contact slots, notes

**Editing pattern:** Each section that contains text fields is a `ConsumerStatefulWidget`. Controllers are created in `initState` from the current provider state and are never reset by rebuilds. `onChanged` calls `notifier.update(...)` immediately on every keystroke. Numeric counters use +/- `IconButton` widgets instead of text fields.

**Usage Dice:** Stored as `int` die size (0=none, 4, 6, 8, 10, 12). Rendered via the shared `udDropdown()` helper defined in `character_sheet_screen.dart`.

**Shared helpers** (defined in `lib/screens/character_sheet_screen.dart`, imported by all tab widgets):
- `sectionHeader(String)` — gold header bar
- `labeledField(...)` — small label + underline `TextField`
- `counterRow(...)` — label + decrement/value/increment row
- `udDropdown(...)` — usage die size picker

**Theme:** Dark military aesthetic in `lib/theme.dart`. Key colors: `kGold` (`#B8860B`), `kGoldLight` (`#DAA520`), `kBg` (`#1A1A1A`), `kSurface` (`#2A2A2A`).

## Known open questions

- Attribute modifier formula: currently `(score - 10) ~/ 2` (D&D standard). Verify against game rules PDF before relying on derived skill totals.
- The two "DR" columns on the paper sheet are mapped to `dr` (armor DR) and `drShield` (shield DR) — confirm this interpretation.
- Skill total formula: `ranks + attrMod`. Confirm whether the game adds anything else.
