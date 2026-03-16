# Agent Project Starter Pack v3

Includes:
- `AGENTS.md`
- `memory-bank/` starter files
- generated index placeholders
- `.clineignore`
- `.gitignore`
- bootstrap scripts
- a Python repository index generator
- optional git hook installers
- ready-to-use git hooks

## Quick start

1. Copy this pack into your repo root.
2. Run:
   ```bash
   python scripts/generate_repo_index.py
   ```
3. Optionally install git hooks:
   - Windows PowerShell:
     ```powershell
     ./scripts/install-git-hooks.ps1
     ```
   - macOS/Linux:
     ```bash
     bash scripts/install-git-hooks.sh
     ```
Note windows powershell users might need to run 

```
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
```

In the terminal before running the .ps1 scripts

## What the hooks do

- `post-commit`: regenerates the repository index after each commit
- `post-merge`: regenerates the repository index after merges/pulls
- `post-checkout`: regenerates the repository index when switching branches

This helps keep:
- `memory-bank/repoMap.generated.md`
- `memory-bank/fileInventory.generated.md`
- `memory-bank/recentChanges.generated.md`

fresh automatically.
