# Naming

Backend:

- Domain services: no `Sys` prefix (`UserDomainService`).
- Persistence / system adapters: `Sys*` (`SysUserService`, `SysDictService`) until a dedicated rename.
- Tables: `sys_*`, `blog_*`.
- Permissions: `{resource}:{action}` — `list|query|add|edit|remove|export|import`.

Frontend:

- Admin API modules under `src/api/`.
- Views under `src/views/system/` for business, demo pages under a “dev reference” group (backlog).
