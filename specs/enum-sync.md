# Enum sync

Shared numeric/string enums are a contract. They live in [`enums/enums.yaml`](../enums/enums.yaml).

## Flow

```
Backend Java enum changes
        │
        ▼
  enums/enums.yaml   (this repo, same change)
        │
        ▼
  Admin / Web TypeScript constants + labels
```

1. Change the Java enum (and dictionary annotation if any).
2. Update `enums/enums.yaml` in the same pull request / commit series.
3. Update the frontend mapping that renders that field.
4. Do not ship a backend value the UI cannot name.

## MenuTypeEnum

Canonical **backend** values (this is the contract):

| Value | Name | Meaning |
|------:|------|---------|
| 1 | DIRECTORY | 目录 |
| 2 | MENU | 菜单 |
| 3 | BUTTON | 按钮 |

Admin `src/views/system/menu/utils/enums.ts` (`menuTypeOptions`) **must stay aligned** with these values. Do not keep a separate 0/1/2/3 UI mapping.

## Other registered enums

- `StatusEnum`: `0` disable / `1` enable
- `UserStatus`: `1` normal / `2` disabled / `3` frozen

If a UI hard-codes these numbers, it must match `enums.yaml`.
