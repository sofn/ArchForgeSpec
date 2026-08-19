# AGENTS.md

## Git Commit Rules

- Do NOT append `Co-Authored-By` lines to commit messages.

## Project Context

This repository owns ArchForge contracts and AI context. Sibling clones, no submodules. Read [`repos.yaml`](repos.yaml) first, then [`architecture.md`](architecture.md).

```
archforge/
├── ArchForge/          # backend: server-admin :8080 + server-web :8081
├── ArchForgeWeb/       # C-end Next.js — consumes server-web :8081
├── ArchForgeAdmin/     # admin UI — consumes server-admin :8080
├── ArchForgeDocs/      # VitePress
└── ArchForgeSpec/      # this repo
```

- `can_modify` here: spec + contract only.
- Do not invent deleted APIs (`/system/menu`, `/system/role`).
- Backend standard lives in `../ArchForge/skills/archforge-project-standard/standard.md` ([pointer](specs/backend-standard.md)).
