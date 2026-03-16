# AGENTS.md

## Purpose

This repository uses a persistent memory system so AI coding agents can work efficiently without repeatedly scanning the entire codebase.

Agents must maintain and use a Memory Bank that stores compressed knowledge about the repository.

Goals:

- minimize unnecessary codebase rescans
- persist learning across sessions
- compress architecture knowledge
- make work sessions resumable
- track technical decisions

The Memory Bank is the primary source of project knowledge.

Agents must treat it as authoritative before exploring the repository.

---

# CRITICAL RULE

Agents must treat the Memory Bank as authoritative project knowledge.

Do NOT rescan the repository unless the Memory Bank does not contain sufficient information.

---

# Agent Workflow

When starting any task:

1. Read `AGENTS.md`
2. Load all files in `/memory-bank`
3. Determine if the task can be solved using memory
4. Read machine-generated index files
5. Only explore code if necessary
6. After completing work, update the Memory Bank
7. Regenerate repository indexes after significant code changes

---

# Memory Bank Location

All persistent knowledge is stored in:

```text
/memory-bank/
```

Structure:

```text
memory-bank/
    activeContext.md
    architecture.md
    systemPatterns.md
    decisions.md
    progress.md
    taskJournal.md
    codeIndex.md
    repoMap.md
    fileLedger.md
    dependencyNotes.md
    repoMap.generated.md
    fileInventory.generated.md
    recentChanges.generated.md
```

---

# Human-Maintained Memory Files

## activeContext.md
Current working session state:
- current objective
- files being modified
- recent discoveries
- next steps

## architecture.md
High-level system overview:
- major components
- boundaries
- data flow
- external dependencies

## systemPatterns.md
Reusable patterns:
- framework usage
- conventions
- architectural patterns

## decisions.md
Technical decision log:
- Decision
- Reasoning
- Alternatives considered
- Date

## progress.md
Overall project state:
- completed milestones
- current work
- known bugs
- open problems

## taskJournal.md
Chronological work log:
- Date
- Task
- Files modified
- Outcome
- Key discoveries

## codeIndex.md
Compressed index of important repo locations.

## repoMap.md
Curated LLM-friendly repository map.

## fileLedger.md
High-value file summaries:
- path
- purpose
- last reviewed
- subsystem
- responsibilities
- change frequency

### fileLedger Rule
If a file is already documented in `fileLedger.md`, agents should not re-read it unless:
- the task directly involves that file
- adjacent code changed
- memory appears incomplete
- there is reason to suspect behavior changed

## dependencyNotes.md
Compact cross-file relationships for fast navigation.

---

# Machine-Generated Repository Index

Agents must read these generated files before broad code exploration:

- `memory-bank/repoMap.generated.md`
- `memory-bank/fileInventory.generated.md`
- `memory-bank/recentChanges.generated.md`

Use generated memory for:
- file discovery
- entrypoint lookup
- recent change detection
- dependency navigation

Use human-maintained memory for:
- architecture meaning
- design decisions
- patterns
- progress
- task history

If generated index files are missing, outdated, or inconsistent with observed structure, regenerate them before broad exploration.

---

# Generated Index Refresh Rule

After significant code changes, agents should regenerate repository index files by running:

```bash
python scripts/generate_repo_index.py
```

If git hooks are installed, this may happen automatically after commits.

---

# Knowledge Compression Rule

Agents must summarize discoveries into short, structured knowledge.

Prefer compact summaries over long explanations.

---

# Change-First Exploration Protocol

When working on a new task, agents must follow this order:

1. Read `AGENTS.md`
2. Read `memory-bank/activeContext.md`
3. Read `memory-bank/repoMap.md`
4. Read `memory-bank/repoMap.generated.md`
5. Read `memory-bank/codeIndex.md`
6. Read `memory-bank/fileLedger.md`
7. Read `memory-bank/dependencyNotes.md`
8. Read `memory-bank/recentChanges.generated.md`
9. Read `memory-bank/fileInventory.generated.md`
10. Read other memory files only as needed
11. Only then inspect code files directly

When direct code inspection is needed, prefer this order:
1. files explicitly mentioned in the task
2. files listed in `activeContext.md`
3. files linked in `dependencyNotes.md`
4. files highlighted by `recentChanges.generated.md`
5. subsystem entrypoints from `repoMap.md` or `repoMap.generated.md`
6. only then broader exploration

---

# Unchanged File Rule

If a file has already been summarized in memory and there is no indication it changed, agents should rely on the summary first.

Do NOT re-read unchanged files just to regain context.

---

# Locality Rule

When a change is made, agents should assume the most likely related files are:
- the file being edited
- its immediate imports/dependencies
- its callers
- subsystem entrypoints

Agents should not expand beyond local dependency distance unless necessary.

---

# Memory Maintenance Rule

Whenever an agent reads an important file deeply, it should add or update an entry in `fileLedger.md`.

Whenever an agent learns a cross-file relationship, it should update `dependencyNotes.md`.

Whenever a task finishes, the agent should update:
- `activeContext.md`
- `progress.md`
- `taskJournal.md`

---

# Memory Compaction Protocol

The memory bank must remain concise and high-signal.

Compaction should occur when:
- `taskJournal.md` exceeds ~200 entries
- `progress.md` grows beyond ~200 lines
- multiple tasks complete within the same subsystem
- a milestone has been reached

If memory-bank files exceed 2000 lines combined, compact historical memory before continuing.

Agents may archive old task journal entries instead of deleting them.

---

# Strong Enforcement Rule

In large repositories, agents must not perform full-repository scans unless:
- the task is explicitly architectural
- memory files are missing or outdated
- the relevant subsystem cannot be identified from memory

If broad exploration is necessary, document why in `taskJournal.md`.

---

# Ignore Rules

Agents should ignore directories that rarely contain project logic unless required.

Examples:

```text
node_modules/
dist/
build/
coverage/
.cache/
venv/
__pycache__/
logs/
tmp/
```

---

# Agent Behavior Summary

Agents working in this repository must:
- read memory before code
- read generated indexes before broad scanning
- update memory after discoveries
- compress knowledge into structured summaries
- avoid unnecessary rescanning
- maintain cumulative project understanding
