# Skill: Admin page development

1. Confirm the API exists in openapi.yaml.
2. Read `enums/enums.yaml` before hardcoding status/type values.
3. Call via `src/utils/http`; expect `{code,message,data}`.
4. Guard buttons with `v-perms` matching `sys_menu.permission`.
5. Do not invent `/system/role` or `/system/menu` — those controllers are gone.
