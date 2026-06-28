---
name: orchestrate
description: /orchestrate <feature> — the multi-agent upgrade to /branch: decompose, fan out parallel implementers, adversarially review, verify-by-running, then PR
usage: /orchestrate <feature description>
examples:
  - /orchestrate add a settings page with profile, billing, and notifications tabs
  - /orchestrate migrate frunk's auth from hand-rolled to passkeys + TOTP
allowed-tools:
  - Bash(git:*)
  - Bash(gh:*)
  - Bash(npm:*)
  - Bash(npx:*)
  - Bash(node:*)
  - Read
  - Edit
  - Write
  - Glob
  - Grep
  - Agent
  - Workflow
  - TaskCreate
  - TaskUpdate
  - TaskGet
---

# Orchestrate (multi-agent build)

The "current" upgrade to `/branch`: instead of one agent doing everything serially, **decompose the feature, fan out parallel implementers, verify adversarially, then integrate.** Use this for **larger features with independent parts** (multiple pages / modules / endpoints) or broad migrations. For a small, single-file change, just use `/branch` — orchestration overhead isn't worth it.

Follows all of `/branch`'s **Implementation Rules**, **commit style** (`commitStyle` in `<project>/.claude/settings.json`), **automerge** gating, and the **zero-AI-attribution** rule.

## Workflow

### 1. Branch + plan the decomposition
- Create the feature branch (as `/branch` step 1).
- Scan the codebase, then **decompose** the feature into independent units that can be built in parallel without colliding (by page, component, route, schema, or layer). List them. If the feature is genuinely one indivisible unit, stop and hand off to `/branch`.

### 2. Fan out implementers (parallel)
Spawn one **Agent subagent per independent unit**, running concurrently. Because they touch the working tree in parallel, give each `isolation: 'worktree'` (or scope each strictly to its own files) to avoid conflicts. Each subagent:
- builds its unit to the **Implementation Rules**,
- writes Vitest unit/component tests + Playwright e2e for its unit,
- returns a structured summary (files changed, tests added, assumptions made).

For very large or open-ended work, use the **Workflow** tool to pipeline decomposition → parallel implement → review with deterministic fan-out.

### 3. Integrate
Merge the units back onto the feature branch (resolve overlaps), then run the **full suite** (unit + e2e). Fix integration gaps.

### 4. Adversarial review (parallel)
Spawn **multiple independent reviewer subagents**, each with a distinct lens — correctness, security, performance, and "does it actually reproduce the requested behavior." Each tries to **refute** the work; a finding survives only if a majority don't refute it. (Or run `/code-review` — `ultra` for the cloud multi-agent pass on big changes.) Fix everything confirmed.

### 5. Verify by running
Don't trust tests alone — **run the app** and observe the feature working (à la `/verify`): start the dev server, exercise the happy path + key edge cases, screenshot if UI. Fix anything that misbehaves.

### 6. Finalize
Slop check, README, final commit, **open the PR** (no AI attribution), then honor the project's `automerge` setting exactly as `/branch` does (default off → leave the PR open for review).

## Notes
- This is opt-in multi-agent orchestration and can spawn many subagents — scale the fan-out to the feature (a 3-part feature needs 3 implementers, not 12).
- Prefer worktree isolation whenever implementers write files in parallel.
