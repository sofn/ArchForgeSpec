# ArchForge Architecture

> This document describes the cross-repository architecture of ArchForge.
> It is owned by `ArchForgeSpec` and derived from the actual source code.
> Detailed documentation lives in the `ArchForgeDocs` repository (VitePress site).

## 1. Repositories

ArchForge is an AI Native Enterprise Application Platform organized as five
independent Git repositories, cloned side by side:

```
archforge/
├── ArchForge/          # backend: server-admin :8080 + server-web :8081
├── ArchForgeWeb/       # C-end web client (Next.js)
├── ArchForgeAdmin/     # admin client (vue-pure-admin)
├── ArchForgeDocs/      # documentation site (VitePress)
└── ArchForgeSpec/      # contracts / architecture / AI context (this repo)
```

All are independent Git repositories. There is **no parent repository** and
**no Git submodule**. Their relationship is association, not containment, and is
described by [`repos.yaml`](repos.yaml).

## 2. Topology

```
                       ┌─────────────────────┐
                       │     ArchForgeSpec   │
                       │   (contracts)       │
                       └──────────▲──────────┘
                 implements / conforms / documents
              ┌────────────┬───┴────────┬────────────┐
              │            │            │            │
       ┌──────┴──────┐ ┌───┴────┐ ┌─────┴──────┐ ┌───┴────────┐
       │  ArchForge  │ │  Web   │ │   Admin    │ │  Docs      │
       │  (backend)  │ │(client)│ │  (client)  │ │ (VitePress)│
       └──▲───────▲──┘ └───▲────┘ └─────▲──────┘ └────────────┘
          │       │        │            │
          │       └────────┴────────────┘
          │      api-consumer (Sa-Token bearer JWT)
          └───────────────┘
```

- `ArchForge` is the backend, the sole API provider. It hosts **two** Spring Boot
  applications: `server-admin` (port 8080) and `server-web` (port 8081).
- `ArchForgeWeb` consumes `server-web` (8081).
- `ArchForgeAdmin` consumes `server-admin` (8080).
- `ArchForgeDocs` documents the whole project.
- `ArchForgeSpec` defines the contracts all repositories conform to.

## 3. Backend (`ArchForge`)

Group `com.lesofn.archforge`, version `1.0.0`.

### Technology

| Concern        | Choice                                        |
|----------------|-----------------------------------------------|
| Language       | Java 25 (preview enabled)                     |
| Framework      | Spring Boot 4.1.0                             |
| Build          | Gradle (Kotlin DSL)                           |
| Persistence    | JPA / Hibernate (PostgreSQL)                  |
| Cache / Lock   | Redis (Lettuce) / Redisson                    |
| Scheduling     | Quartz (JDBC, clustered, PostgreSQL)          |
| Auth           | Sa-Token (bearer JWT)                         |
| API docs       | springdoc OpenAPI 3.1 (`/v3/api-docs`, `/swagger-ui.html`) |
| Observability  | Micrometer + OpenTelemetry (OTLP)             |
| Native image   | GraalVM native (plugin configured)            |
| Tests          | JUnit 5 + Spock 2.4 (Groovy 5)                |

### Modules

```
ArchForge/
├── common/          # common-base, common-jpa, common-error
├── infrastructure/  # shared infrastructure (security, swagger, tracing)
├── dependencies/    # dependency version platform (BOM)
├── server-admin/    # admin REST API (port 8080)
├── server-web/      # consumer web REST API (port 8081)
├── domain/          # blog, admin-user, meta-table
├── starters/        # redisson, cache, lock, trace
└── example/         # sample modules
```

### Enforcement rules (from `build.gradle.kts`)

- Code style enforced by Spotless (Eclipse JDT formatter).
- EasyExcel is forbidden project-wide; use `org.dhatim:fastexcel`.
- Logback/Log4j bridge excluded; Spring Boot logging starter excluded globally.

## 4. Frontends

### ArchForgeWeb (C-end)

- Next.js 15 (App Router) + React 19 + TypeScript
- Tailwind CSS v4 + shadcn/ui
- i18n: next-intl (`en`, `zh`)
- Monorepo: pnpm workspaces + Turborepo (`apps/web/`)
- Auth: Sa-Token based login
- API base: `http://localhost:8081` (server-web)

### ArchForgeAdmin (admin)

- Based on `vue-pure-admin` 7.0
- Vue 3.5 + Vite 8 + TypeScript + Element Plus + Pinia + vue-router 5 + vue-i18n
- Tailwind CSS v4
- Tooling: husky + commitlint + lint-staged + ESLint + Prettier + Stylelint
- Node >= 22.22.1, pnpm >= 11
- API base: `http://localhost:8080` (server-admin)

## 5. Documentation (`ArchForgeDocs`)

- VitePress 1.6 site, deployed to GitHub Pages on `master`.
- Sections: `guide/` (intro, quick-start, local-setup, tech-stack, project-structure,
  configuration, orm-query, dependency-management, database-migration),
  `modules/` (api-docs, authentication, user-management, role-permission,
  menu-management, config-notice, log-management, server-monitor),
  `deploy/` (docker, production, test-environment), plus `zh/` Chinese mirror.

## 6. Contract Layer

All cross-repository contracts live in this repository:

| Contract        | Location                    | Standard            |
|-----------------|-----------------------------|---------------------|
| HTTP API        | `api/openapi.yaml`          | OpenAPI 3.1.x       |
| UI DSL          | `schemas/ui/`               | JSON Schema 2020-12 |
| Workflow DSL    | `schemas/workflow/`         | JSON Schema 2020-12 |
| Permission      | `schemas/permission/`       | JSON Schema 2020-12 |
| Agent           | `schemas/agent/`            | JSON Schema 2020-12 |

> Status of `schemas/`: currently schema skeletons awaiting the corresponding
> domain models. The authoritative API contract is generated by springdoc from
> the backend source at `/v3/api-docs`; `api/openapi.yaml` is the curated
> contract view that must stay in sync with it.

OpenAPI 3.1 is directly compatible with JSON Schema 2020-12, so schema reuse
across the API contract and domain schemas is straightforward.

Contract changes follow SemVer. Breaking contract changes require a major
version bump and coordination across repositories.

## 7. Repository Independence

- Each repository has its own `.git`, remote, branches, and release cadence.
- Never nest repositories or introduce submodules.
- A repository must remain buildable even if sibling repositories are absent.
- Cross-repository knowledge comes only from `ArchForgeSpec` (via `AGENTS.md`
  → `repos.yaml` → sibling paths), never from Git metadata.

## 8. AI Collaboration Model

AI agents enter from any repository and build project context as follows:

```
<repo>/AGENTS.md
      ↓
../ArchForgeSpec/repos.yaml
      ↓
discover ../ArchForge, ../ArchForgeWeb, ../ArchForgeAdmin, ../ArchForgeDocs, ../ArchForgeSpec
      ↓
missing siblings? → scripts/bootstrap.sh
      ↓
read each repository's AGENTS.md
      ↓
project-level context established
```

See [AGENTS.md](AGENTS.md) for the full AI collaboration rules.

## 9. Future Extensions (non-goals for now)

- SDK generation / publishing (npm / Maven)
- Contract compilers, generators, runtimes
- Additional clients (mini program, Android) — registered in `repos.yaml` when they exist
