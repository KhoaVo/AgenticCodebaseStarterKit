# AGENTS.md

## Purpose

This repository uses a **persistent memory system** so AI coding agents (Cline, Roo Code, Cursor, etc.) can work efficiently without repeatedly scanning the entire codebase.

Agents must maintain and use a **Memory Bank** that stores compressed knowledge about the repository.

Goals:

- minimize unnecessary codebase rescans
- persist learning across sessions
- compress architecture knowledge
- make work sessions resumable
- track technical decisions

The **Memory Bank is the primary source of project knowledge**.

Agents must treat it as authoritative before exploring the repository.

---

# CRITICAL RULE

Agents must treat the Memory Bank as **authoritative project knowledge**.

Do **NOT** rescan the repository unless the Memory Bank does not contain sufficient information.

---

# Agent Workflow

When starting any task:

1. Read `AGENTS.md`
2. Load all files in `/memory-bank`
3. Determine if the task can be solved using memory
4. Only explore code if necessary
5. After completing work, update the Memory Bank

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
```

---

# Memory File Responsibilities

## activeContext.md

Represents the **current working session state**.

Update when:

- starting a task
- finishing a task
- discovering new insights

Contents:

- current objective
- files being modified
- recent discoveries
- next steps

---

## architecture.md

High-level system overview.

Contains:

- major components
- module relationships
- system boundaries
- data flow
- external dependencies

Update when architecture changes or is discovered.

---

## systemPatterns.md

Reusable patterns across the codebase.

Examples:

- framework usage patterns
- coding conventions
- common architecture patterns
- dependency patterns

Update whenever a repeatable pattern is discovered.

---

## decisions.md

History of important technical decisions.

Each entry should contain:

- Decision
- Reasoning
- Alternatives considered
- Date

This prevents re-evaluating previous design decisions.

---

## progress.md

Tracks overall project state.

Includes:

- completed milestones
- current work
- known bugs
- open problems
- roadmap ideas

---

## taskJournal.md

Chronological log of agent work sessions.

Each entry:

- Date
- Task
- Files Modified
- Outcome
- Key Discoveries

Always append — never overwrite previous entries.

---

## codeIndex.md

Compressed index of important repository locations.

Example:

```text
/src/api/
    server.ts — API entrypoint

/src/db/
    schema.ts — database schema

/src/services/
    auth.ts — authentication logic
```

Helps agents quickly locate relevant files.

---

## repoMap.md

`repoMap.md` contains a **compressed LLM-friendly map of the repository**.

Purpose:

- avoid scanning large directory trees
- quickly identify subsystem boundaries
- provide a fast lookup of important modules

Example format:

```text
Core System

/src/server
    main.ts — application entrypoint

/src/auth
    authService.ts — authentication logic

/src/db
    database.ts — DB connection manager
```

Agents should update this map whenever:

- new subsystems appear
- important directories are discovered
- major files are added

This map acts as a **lightweight index of the entire repository**.

---

## fileLedger.md

This file tracks high-value files that have already been inspected.

Each entry should include:

- path
- purpose
- last reviewed date
- related subsystem
- important exports / responsibilities
- whether the file is likely stable or frequently changed

Example:

```text
/src/auth/authService.ts
Purpose: Main authentication service
Last Reviewed: 2026-03-15
Subsystem: Auth
Responsibilities:
- login flow
- token refresh
- session validation
Change Frequency: medium
Notes:
- central dependency for auth middleware
- check this first for login-related tasks
```

### fileLedger Rule

If a file is already documented in `fileLedger.md`, agents should not re-read it unless:

- the task directly involves that file
- adjacent code changed
- memory appears incomplete
- there is reason to suspect behavior changed

---

## dependencyNotes.md

This file stores compact cross-file relationships so the agent can navigate directly instead of scanning.

Example:

```text
Auth subsystem
- authMiddleware.ts -> uses authService.ts
- authService.ts -> uses jwtUtils.ts and userRepo.ts
- routes/authRoutes.ts -> entrypoint for login/logout endpoints
```

### dependencyNotes Rule

Before exploring a subsystem, agents should read `dependencyNotes.md` to jump directly to likely relevant files.

---

# Knowledge Compression Rule

Agents must summarize discoveries into **short, structured knowledge**.

Instead of long explanations:

BAD:

```text
Authentication is implemented across several files including middleware,
JWT handlers, and user models.
```

GOOD:

```text
Authentication System

Modules:
- authMiddleware.ts
- jwtUtils.ts
- userModel.ts

Pattern:
JWT stateless authentication
```

Compression keeps memory **high signal and efficient**.

---

# Change-First Exploration Protocol

When working on a new task, agents must follow this order:

1. Read `AGENTS.md`
2. Read `memory-bank/activeContext.md`
3. Read `memory-bank/repoMap.md`
4. Read `memory-bank/codeIndex.md`
5. Read `memory-bank/fileLedger.md`
6. Read `memory-bank/dependencyNotes.md`
7. Read other memory files only as needed
8. Only then inspect code files directly

When direct code inspection is needed, prefer this order:

1. files explicitly mentioned in the task
2. files listed in `activeContext.md`
3. files linked in `dependencyNotes.md`
4. subsystem entrypoints from `repoMap.md`
5. only then broader exploration

Agents must avoid broad searches when a likely file path is already available in memory.

---

# Unchanged File Rule

If a file has already been summarized in memory and there is no indication it changed, agents should rely on the summary first.

Do **NOT** re-read unchanged files just to regain context.

Instead:

- use the existing summary
- inspect only the exact function/class needed
- update the summary only if new knowledge is discovered

---

# Locality Rule

When a change is made, agents should assume the most likely related files are:

- the file being edited
- its immediate imports/dependencies
- its callers
- subsystem entrypoints

Agents should not expand beyond local dependency distance unless necessary.

---

# Code Exploration Rules

Agents must minimize repository scanning.

Before reading code:

1. Check Memory Bank
2. Check `repoMap.md`
3. Check `codeIndex.md`
4. Identify likely modules
5. Only read relevant files

Avoid:

- scanning entire directories
- reading dependency folders
- repeatedly loading the same files

---

# File Reading Priority

Agents should read files in this order:

1. `AGENTS.md`
2. `memory-bank/activeContext.md`
3. `memory-bank/repoMap.md`
4. `memory-bank/codeIndex.md`
5. `memory-bank/fileLedger.md`
6. `memory-bank/dependencyNotes.md`
7. `memory-bank/architecture.md`
8. `memory-bank/systemPatterns.md`
9. `memory-bank/decisions.md`
10. `memory-bank/progress.md`
11. `memory-bank/taskJournal.md`

Only then explore the repository.

---

# Memory Maintenance Rule

Whenever an agent reads an important file deeply, it should add or update an entry in `fileLedger.md`.

Whenever an agent learns a cross-file relationship, it should update `dependencyNotes.md`.

Whenever a task finishes, the agent should update:

- `activeContext.md`
- `progress.md`
- `taskJournal.md`

This ensures future sessions do not repeat the same investigation.

---

# Fast Resume Rule

At the start of a session, agents should prefer reconstructing understanding from:

- `activeContext.md`
- recent `taskJournal.md` entries
- `repoMap.md`
- `fileLedger.md`

Agents should treat these as the default resume path instead of rescanning the repository.

---

# Change Documentation

Whenever code changes occur, agents must document:

- Files modified
- Purpose of change
- Architectural impact
- Follow-up tasks

Add a summary entry to `taskJournal.md`.

---

# Optional Strong Enforcement Rule

If operating in a large repository, agents must not perform full-repository scans unless:

- the task is explicitly architectural
- memory files are missing or outdated
- the relevant subsystem cannot be identified from memory

If broad exploration is necessary, agents should document why it was necessary in `taskJournal.md`.

---

# Performance Goals

This memory system should allow agents to:

- resume work instantly
- avoid redundant analysis
- reduce token usage
- scale to large repositories

Over time the Memory Bank should become a **compressed knowledge model of the repository**.

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
- update memory after discoveries
- compress knowledge into structured summaries
- avoid unnecessary rescanning
- maintain cumulative project understanding

The Memory Bank is the **primary intelligence layer of the repository**.
