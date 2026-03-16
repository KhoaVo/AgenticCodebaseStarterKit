#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
GIT_HOOKS="$REPO_ROOT/.git/hooks"

if [ ! -d "$GIT_HOOKS" ]; then
  echo "No .git/hooks directory found. Run this from inside a Git repository." >&2
  exit 1
fi

cp "$REPO_ROOT/githooks/post-commit" "$GIT_HOOKS/post-commit"
cp "$REPO_ROOT/githooks/post-merge" "$GIT_HOOKS/post-merge"
cp "$REPO_ROOT/githooks/post-checkout" "$GIT_HOOKS/post-checkout"
chmod +x "$GIT_HOOKS/post-commit" "$GIT_HOOKS/post-merge" "$GIT_HOOKS/post-checkout"

echo "Installed Git hooks:"
echo "- post-commit"
echo "- post-merge"
echo "- post-checkout"
echo "They will regenerate memory-bank indexes automatically."
