# API response formats

**Decision D2:** keep two formats by domain. Do not force-unify.

| App | Success | Error |
|-----|---------|-------|
| server-admin | `{code:0, message, data}` | same envelope or ProblemDetail for auth (401/403) |
| server-web | resource JSON | RFC 9457 `ProblemDetail` |

Admin list payloads usually wrap `list/total/pageSize/currentPage` inside `data`.
