# API path prefixes

| Prefix | Owner |
|--------|--------|
| `/auth/*` | Admin login, captcha, config |
| `/admin/*` | Admin business APIs |
| `/web/*` | C-end APIs |
| `/file/*`, `/quartz/*` | Admin (historical, treat as admin) |
| `/system/dict` | Legacy — migrate to `/admin/dict` (backlog) |

Deleted and must not return: `/system/menu/*`, `/system/role/*`.
