# ArchForgeSpec

[English](./README.md) | 中文

[![CI](https://github.com/sofn/ArchForgeSpec/actions/workflows/ci.yml/badge.svg)](https://github.com/sofn/ArchForgeSpec/actions/workflows/ci.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](./LICENSE)

**给 AI Agent 读的项目宪法。** ArchForge 五仓的契约、架构与 AI 上下文——不含业务代码。

本仓库是以下内容的事实源：

- 五仓地图（`repos.yaml`、`architecture.md`）
- HTTP 契约（`api/openapi.yaml`）
- 共享枚举（`enums/enums.yaml`）
- 跨仓规范（`specs/`）
- Agent skills（`skills/`）

请与 `ArchForge`、`ArchForgeAdmin`、`ArchForgeWeb`、`ArchForgeDocs` 并列克隆。

文档：[https://archforge.lesofn.com](https://archforge.lesofn.com)

## 规则

1. API / 枚举 / 路径对不上客户端时，先改本仓。
2. 不要发明已删除端点。`/system/menu` 和 `/system/role` **不在契约里**。
3. 后端编码规范在后端仓。本仓只 [指向它](specs/backend-standard.md)。
4. 永远不要引入 Git submodule。

## License

MIT
