# Security

Applies to both `server-admin` and `server-web`.

## sa-token

Auth is **sa-token**, not Spring Security JWT.

| Realm | Util | Server | Client |
|-------|------|--------|--------|
| Admin | `StpAdminUtil` | :8080 | ArchForgeAdmin |
| Web | `StpWebUtil` | :8081 | ArchForgeWeb |

- Header: `Authorization: Bearer <token>` when `tokenName` is `Authorization`.
- Admin stores token in cookie `authorized-token` + localStorage `user-info`.
- Web stores `token`, `tokenName`, `refreshToken` in cookies (and localStorage mirror).
- Tokens from one realm must not be sent to the other.

Login / refresh endpoints are public. Everything else requires login unless explicitly opened.

## SaCheckPermission / role

Admin controllers currently gate with `@SaCheckRole(value = "ADMIN", type = StpAdminUtil.TYPE)`.

Finer-grained checks use **sa-token permission annotations**:

```java
@SaCheckPermission(value = "system:user:add", type = StpAdminUtil.TYPE)
```

Permission strings come from `sys_menu.permission` and must match Admin `v-perms` / `hasPerms()`.

- New mutating admin APIs need a permission (or an explicit documented exemption).
- Do not invent permission codes in the frontend only.

Auth failures: HTTP 401 / 403 ProblemDetail (`AdminAuthExceptionHandler`).

## RateLimit

`@RateLimit` (Redis + Lua) on sensitive public endpoints.

```java
@RateLimit(key = "login", time = 60, maxCount = 10, limitType = RateLimit.LimitType.IP)
```

| `LimitType` | Key |
|-------------|-----|
| `GLOBAL` | method |
| `IP` | client IP |
| `USER` | login id |

Required on login, register, verification-code, password-reset. Exceeded → `SystemErrorCode.E_RATE_LIMIT_EXCEEDED`.

## XssFilter

Incoming HTML/script in request parameters and JSON strings must be sanitized before persistence (XSS filter / allow-list).

- Admin rich text and C-end Markdown are stored, not executed as HTML, unless explicitly sanitized on render.
- Never persist raw `<script>` from user input.

## CORS

Configured per server (`AdminCorsConfig` and the web equivalent):

- Dev may use origin patterns.
- **Prod forbids `allowedOrigins: *`** when credentials are on. Set explicit origins in env (`arch-forge.cors.allowed-origins`).
- Prefer the global CORS filter over scattering `@CrossOrigin` on controllers.

## Secrets and env

Do **not** commit secrets. Use environment / profile files:

| Kind | Examples |
|------|----------|
| DB | `SPRING_DATASOURCE_*`, Flyway URL |
| Redis | Redis host / password |
| Object storage | S3/RustFS keys |
| Mail | SMTP credentials (C-end verification codes) |
| CORS | production origin list |
| Tokens | sa-token timeout / cookie flags |

Local templates stay as `.env.example` / `application-*.yaml.example`. Production values come from the environment, never from git.
