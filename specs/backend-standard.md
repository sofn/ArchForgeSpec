# Backend standard

The canonical backend standard stays **next to the code**, not in this repo.

**Read:** `../ArchForge/skills/archforge-project-standard/standard.md`

That file owns Java / Gradle / testing / deployment conventions for `ArchForge`.

## Decision

Keep `standard.md` in the backend `skills/` tree so it versions with the code it describes. ArchForgeSpec **references** it; it does not copy or fork it.

When the backend standard changes, update that file in `ArchForge`. Only add a Spec doc when the rule is cross-repo (paths, enums, response format, naming across clients).
