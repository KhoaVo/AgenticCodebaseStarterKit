#!/usr/bin/env bash
set -e

if git diff --quiet && git diff --cached --quiet; then
  echo "No changes to commit."
  exit 0
fi

git add -A
git commit -m "checkpoint: $(date '+%Y-%m-%d %H:%M:%S')"
