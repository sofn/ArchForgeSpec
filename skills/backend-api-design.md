# Skill: backend API design

Use when adding or changing HTTP APIs in `ArchForge`.

## Before coding

1. Read [`../architecture.md`](../architecture.md) and [`../specs/api-path.md`](../specs/api-path.md).
2. Decide the server: admin `:8080` or web `:8081`.
3. Put the path under `/admin/*` or `/web/*`. Never add `/system/menu` or `/system/role`.
4. Update [`../api/openapi.yaml`](../api/openapi.yaml) in the same change.

## Shape

- Controller in the matching server module, thin, constructor-injected.
- Request / Response types (`XxxCreateRequest`, `XxxDetailResponse`).
- Auth: `@SaCheckLogin` / `@SaCheckRole` / `@SaCheckPermission` with the correct `Stp*Util.TYPE`.
- Sensitive public endpoints: `@RateLimit`.
- Errors: module `ErrorCode` + exception. See [`../specs/error-codes.md`](../specs/error-codes.md).
- Admin success: envelope `{code, message, data}`.
- Web errors: ProblemDetail.

## After coding

- Enum value changed? Update [`../enums/enums.yaml`](../enums/enums.yaml) and the frontend ([`enum-sync.md`](../specs/enum-sync.md)).
- Do not edit Admin or Web unless the task explicitly spans repos ([`cross-repo-change.md`](cross-repo-change.md)).
