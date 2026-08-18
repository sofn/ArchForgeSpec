#!/usr/bin/env bash
# check-workspace.sh — verify that all ArchForge sibling repositories exist
# and are independent Git repositories (no submodules, no nesting).
#
#   ./scripts/check-workspace.sh
#
# Exit code 0 = workspace OK; 1 = problems found.

set -uo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
WORKSPACE="$(dirname "$ROOT")"

repos=(ArchForge ArchForgeWeb ArchForgeAdmin ArchForgeDocs ArchForgeSpec)

echo "Workspace: $WORKSPACE"
fail=0

for repo in "${repos[@]}"; do
  dir="$WORKSPACE/$repo"
  if [ ! -d "$dir" ]; then
    echo "[MISSING] $repo — run ./scripts/bootstrap.sh"
    fail=1
  elif [ ! -d "$dir/.git" ]; then
    echo "[INVALID] $repo exists but is not a Git repository"
    fail=1
  else
    echo "[OK]      $repo ($(git -C "$dir" branch --show-current 2>/dev/null || echo 'detached'))"
  fi
done

# Nested repositories / submodules are forbidden.
for repo in "${repos[@]}"; do
  dir="$WORKSPACE/$repo"
  [ -d "$dir" ] || continue
  if [ -f "$dir/.gitmodules" ]; then
    echo "[FORBIDDEN] $repo uses Git submodules — remove them"
    fail=1
  fi
done

if [ "$fail" -eq 0 ]; then
  echo "Workspace OK."
else
  echo "Workspace has problems (see above)."
  exit 1
fi
