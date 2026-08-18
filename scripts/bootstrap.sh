#!/usr/bin/env bash
# bootstrap.sh — clone or update all ArchForge sibling repositories.
# Run from anywhere inside ArchForgeSpec (typically the repo root).
#
#   ./scripts/bootstrap.sh
#
# Result:
#   workspace/
#   ├── ArchForge/
#   ├── ArchForgeWeb/
#   ├── ArchForgeAdmin/
#   ├── ArchForgeDocs/
#   └── ArchForgeSpec/

set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
WORKSPACE="$(dirname "$ROOT")"

echo "Workspace: $WORKSPACE"
mkdir -p "$WORKSPACE"

clone_or_update() {
  local repo="$1"
  local url="$2"
  if [ -d "$WORKSPACE/$repo/.git" ]; then
    echo "Updating $repo"
    git -C "$WORKSPACE/$repo" pull --ff-only
  else
    echo "Cloning $repo"
    git clone "$url" "$WORKSPACE/$repo"
  fi
}

clone_or_update "ArchForge"      "https://github.com/sofn/ArchForge"
clone_or_update "ArchForgeWeb"   "https://github.com/sofn/ArchForgeWeb"
clone_or_update "ArchForgeAdmin" "https://github.com/sofn/ArchForgeAdmin"
clone_or_update "ArchForgeDocs"  "https://github.com/sofn/ArchForgeDocs"
# ArchForgeSpec is this repository; clone only if missing.
clone_or_update "ArchForgeSpec"  "https://github.com/sofn/ArchForgeSpec"

echo "Done. Workspace layout:"
ls -1 "$WORKSPACE"
