# Security

- Auth: sa-token 1.45 (`StpAdminUtil`, `StpWebUtil`).
- Admin controllers: class `@SaCheckLogin` + write `@SaCheckPermission("resource:action")`.
  Strings must match `sys_menu.permission` and Admin `v-perms`.
- Login: `@RateLimit` 5 / 60s / IP (disabled on `test` profile).
- File upload / meta-table generate also rate-limited.
- `XssFilter`: query/header sanitization; **skip multipart** and binary types.
- CORS: explicit origins; prod rejects `*`.
- Secrets: `${DB_PASSWORD}` with no prod default; `.env` from `./archforge init --write`.
