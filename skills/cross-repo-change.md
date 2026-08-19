# Skill: cross-repo change

Use when a change touches more than one of ArchForge / Admin / Web / Spec.

## Order

```
1. ArchForgeSpec   contract / enum / spec
2. ArchForge       implement the API
3. ArchForgeAdmin  and/or ArchForgeWeb
4. ArchForgeDocs   only if a human guide must change
```

Never start in a client and “make the backend fit later”.

## Checklist

- [ ] Read [`../repos.yaml`](../repos.yaml) and [`../architecture.md`](../architecture.md)
- [ ] Paths follow [`../specs/api-path.md`](../specs/api-path.md)
- [ ] Response format follows [`../specs/api-response.md`](../specs/api-response.md)
- [ ] Enums updated in [`../enums/enums.yaml`](../enums/enums.yaml)
- [ ] OpenAPI stub updated
- [ ] Each repo gets its **own commit** (no submodule, no `Co-Authored-By`)
- [ ] Do not modify a sibling repo unless the task requires it

## Ports (do not swap)

`8080` admin API · `8081` web API · `8848` admin UI · `3000` C-end UI
