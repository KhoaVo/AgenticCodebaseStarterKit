# AGENTS.md

## Purpose

This repository uses a **persistent memory system** so AI coding agents
(Cline, Roo Code, Cursor, etc.) can work efficiently without repeatedly
scanning the entire codebase.

Agents must maintain and use a **Memory Bank** that stores compressed
knowledge about the repository.

Goals:

-   minimize unnecessary codebase rescans
-   persist learning across sessions
-   keep architectural knowledge concise
-   make work sessions resumable
-   track technical decisions

The **Memory Bank is the primary source of project knowledge**.

Agents must treat it as authoritative before exploring the repository.

------------------------------------------------------------------------

# CRITICAL RULE

Agents must treat the Memory Bank as **authoritative project
knowledge**.

Do **NOT rescan the repository** unless the Memory Bank does not contain
sufficient information.

------------------------------------------------------------------------

# Agent Workflow

When starting any task:

1.  Read `AGENTS.md`
2.  Load the Memory Bank files
3.  Determine if the task can be solved using memory
4.  Only explore code if necessary
5.  After completing work, update the Memory Bank

------------------------------------------------------------------------

# Memory Bank Location

All persistent knowledge is stored in:

    /memory-bank/

Structure:

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

------------------------------------------------------------------------

# Memory File Responsibilities

## activeContext.md

Represents the **current working session state**.

Update when:

-   starting a task
-   finishing a task
-   discovering new insights

Contents:

-   current objective
-   files being modified
-   recent discoveries
-   next steps

This file should remain **small and focused**.

------------------------------------------------------------------------

## architecture.md

High-level system overview.

Contains:

-   major components
-   module relationships
-   system boundaries
-   data flow
-   external dependencies

Update when architecture changes or is discovered.

------------------------------------------------------------------------

## systemPatterns.md

Reusable patterns across the codebase.

Examples:

-   coding conventions
-   architecture patterns
-   framework usage patterns
-   dependency patterns

Update whenever a repeatable pattern is discovered.

------------------------------------------------------------------------

## decisions.md

History of important technical decisions.

Each entry should contain:

-   Decision
-   Reasoning
-   Alternatives considered
-   Date

Append entries rather than rewriting history.

------------------------------------------------------------------------

## progress.md

Tracks the project's overall state.

Includes:

-   completed milestones
-   ongoing work
-   known issues
-   next priorities

Periodically summarize older entries to keep this file concise.

------------------------------------------------------------------------

## taskJournal.md

Chronological log of work sessions.

Each entry should include:

-   Date
-   Task
-   Files Modified
-   Outcome
-   Key Discoveries

Always append entries rather than rewriting them.

------------------------------------------------------------------------

## codeIndex.md

Compressed index of important repository locations.

Example:

    /src/api/
        server.ts - API entrypoint

    /src/db/
        schema.ts - database schema

Helps agents quickly locate relevant files without scanning the entire
repo.

------------------------------------------------------------------------

## repoMap.md

Lightweight map of important project areas.

Example:

    Core System

    /src/server
        main.ts - application entrypoint

    /src/auth
        authService.ts - authentication logic

This helps agents locate subsystems quickly.

------------------------------------------------------------------------

## fileLedger.md

Tracks high-value files already inspected by agents.

Each entry should include:

-   path
-   purpose
-   subsystem
-   responsibilities
-   last reviewed date

Agents should avoid re-reading files already documented here unless
necessary.

------------------------------------------------------------------------

## dependencyNotes.md

Compact cross-file relationships.

Example:

    Auth subsystem
    - authMiddleware.ts -> uses authService.ts
    - authService.ts -> uses jwtUtils.ts

This helps agents navigate directly between related files.

------------------------------------------------------------------------

# Knowledge Compression Rule

Agents must summarize discoveries into **short, structured knowledge**.

Avoid long explanations.

Example:

BAD:

    Authentication logic exists across multiple middleware files and services...

GOOD:

    Authentication System

    Modules:
    - authMiddleware.ts
    - authService.ts
    - jwtUtils.ts

    Pattern:
    JWT stateless authentication

Compression keeps memory **high-signal and efficient**.

------------------------------------------------------------------------

# Code Exploration Rules

Agents must minimize repository scanning.

Before reading code:

1.  Check Memory Bank
2.  Check `repoMap.md`
3.  Check `codeIndex.md`
4.  Identify likely modules
5.  Only read relevant files

Avoid:

-   scanning entire directories
-   loading dependency folders
-   repeatedly reading the same files

------------------------------------------------------------------------

# File Reading Priority

Agents should read files in this order:

1.  `AGENTS.md`
2.  `memory-bank/activeContext.md`
3.  `memory-bank/repoMap.md`
4.  `memory-bank/codeIndex.md`
5.  `memory-bank/fileLedger.md`
6.  `memory-bank/dependencyNotes.md`
7.  `memory-bank/architecture.md`
8.  `memory-bank/systemPatterns.md`
9.  `memory-bank/decisions.md`
10. `memory-bank/progress.md`
11. `memory-bank/taskJournal.md`

Only then explore the repository.

------------------------------------------------------------------------

# Memory Compaction Protocol

The Memory Bank must remain **concise and high-signal**.

Agents should periodically compress older memory entries.

### Compaction Triggers

Compaction should occur when:

-   `taskJournal.md` exceeds \~250 entries
-   `progress.md` exceeds \~250 lines
-   the combined Memory Bank exceeds \~2500 lines
-   a major milestone has been completed

### Compaction Behavior

When compacting memory:

1.  Summarize older entries

2.  Preserve important discoveries and decisions

3.  Remove redundant details

4.  Move durable knowledge into:

    -   `architecture.md`
    -   `systemPatterns.md`
    -   `fileLedger.md`

Example:

Before:

    2026-02-10 - fixed auth bug
    2026-02-11 - fixed middleware issue
    2026-02-12 - added refresh token support

After:

    Auth subsystem improvements (Feb 2026)

    - stabilized auth middleware
    - implemented refresh token flow

------------------------------------------------------------------------

# Journal Rotation

Older task journal entries may be archived rather than deleted.

Example:

    memory-bank/
        taskJournal.md
        archives/
            taskJournal-2026-Q1.md

------------------------------------------------------------------------

# Memory Maintenance Rule

Whenever an agent:

-   reads an important file
-   discovers a subsystem
-   identifies a pattern
-   implements a change

It must update the appropriate memory files.

At minimum update:

-   `activeContext.md`
-   `progress.md`
-   `taskJournal.md`

------------------------------------------------------------------------

# Fast Resume Rule

At the start of a new session, agents should reconstruct context from:

-   `activeContext.md`
-   recent `taskJournal.md` entries
-   `repoMap.md`
-   `fileLedger.md`

Agents should **prefer memory over repository rescanning**.

------------------------------------------------------------------------

# Ignore Rules

Agents should ignore directories that rarely contain project logic
unless required.

Examples:

    node_modules/
    dist/
    build/
    coverage/
    .cache/
    venv/
    __pycache__/
    logs/
    tmp/

------------------------------------------------------------------------

# Agent Behavior Summary

Agents working in this repository must:

-   read memory before code
-   update memory after discoveries
-   compress knowledge into concise summaries
-   avoid unnecessary repository rescanning
-   maintain cumulative project understanding

The Memory Bank acts as the **intelligence layer for the repository**.

------------------------------------------------------------------------

# Version Control

Git workflow
- Never git commit automatically unless explicitly asked.
- After completing a meaningful chunk of work, tell me to run `scripts/checkpoint.ps1` or `scripts/checkpoint.sh`.