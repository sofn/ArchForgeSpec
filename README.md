# ArchForge Project

This repository is part of the ArchForge multi-repository project.

`ArchForgeSpec` is the project specification repository:

- **Project map** — machine-readable manifest of all repositories (`repos.yaml`)
- **Architecture** — cross-repository architecture documentation (`architecture.md`)
- **API contract** — OpenAPI 3.1 (`api/openapi.yaml`)
- **Data / DSL schemas** — JSON Schema 2020-12 (`schemas/`)
- **AI context** — `AGENTS.md`
- **Bootstrap** — workspace setup scripts (`scripts/`)

It intentionally does **not** publish SDKs, generators, or runtimes (out of scope for now).
User, module, and deployment documentation lives in the `ArchForgeDocs` repository.

## Related Repositories

- Core (backend): https://github.com/sofn/ArchForge
- Web client: https://github.com/sofn/ArchForgeWeb
- Admin client: https://github.com/sofn/ArchForgeAdmin
- Documentation: https://github.com/sofn/ArchForgeDocs
- Spec (this repo): https://github.com/sofn/ArchForgeSpec

For cross-repository architecture and contracts, see this repository (`ArchForgeSpec`).
For product documentation, see `ArchForgeDocs`.

## Workspace Layout

All five repositories are independent Git repositories cloned side by side:

```
archforge/
├── ArchForge/          # backend (server-admin :8080 + server-web :8081)
├── ArchForgeWeb/       # C-end web client (Next.js)
├── ArchForgeAdmin/     # admin client (vue-pure-admin)
├── ArchForgeDocs/      # documentation site (VitePress)
└── ArchForgeSpec/      # spec / contracts / AI context
```

No parent repository. No Git submodules. Relationships are described by
[`repos.yaml`](repos.yaml).

## Quick Start

```bash
git clone https://github.com/sofn/ArchForgeSpec
cd ArchForgeSpec
./scripts/bootstrap.sh         # clone or update sibling repositories
./scripts/check-workspace.sh  # verify workspace layout
```

## Standards

| Concern         | Standard            |
|-----------------|---------------------|
| HTTP API        | OpenAPI 3.1.x       |
| Data structures | JSON Schema 2020-12 |
| Versioning      | SemVer              |
| Repo guidance   | AGENTS.md / README  |

## AI Agents

See [AGENTS.md](AGENTS.md) for the AI collaboration entrypoint.
