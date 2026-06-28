---
name: new
description: /new <name> <stack> — bootstrap a project: scaffold the stack and stamp <project>/.claude/settings.json (permissions, commit style, automerge, stack)
usage: /new <name> <STACK> [commit=conventional|gitmoji] [perms=loose|tight] [automerge=on|off]
examples:
  - /new loopixel RATS
  - /new retireat55 ZENCATS automerge=on
  - /new no-dinos TANS perms=tight commit=gitmoji
allowed-tools:
  - Bash(npm:*)
  - Bash(npx:*)
  - Bash(node:*)
  - Bash(git:*)
  - Bash(mkdir:*)
  - Bash(ls:*)
  - Read
  - Write
  - Edit
  - Glob
  - Grep
---

# Bootstrap a New Project

Scaffolds a new project in the right stack and stamps its per-project config into `<project>/.claude/settings.json`. This is the "establish it once when I start" moment for **permissions, commit style, automerge, and stack**.

## Arguments

- **name** (required): project slug, e.g. `loopixel`.
- **stack** (required): one of `ZENCATS`, `RAVEHANDS`, `RATS`, `TANS`, `REST`. If missing or unknown, print the five (with one-line expansions from `~/Dev/_PROJECTS.md` → Stacks) and ask — the one exception to running autonomously.
- Optional overrides (else use the global defaults in `~/.claude/CLAUDE.md` → Defaults):
  - `commit=conventional|gitmoji` (default `conventional`)
  - `perms=loose|tight` (default `loose`)
  - `automerge=on|off` (default `off`)

## Steps

### 1. Resolve & validate
- Confirm `stack` is one of the five. Read its expansion from `~/Dev/_PROJECTS.md`.
- Location (follow the convention): `~/Dev/<name>-proj/<name>`. **Stop if it already exists.**

### 2. Scaffold the base framework

| Stack | Base scaffold |
|---|---|
| RATS · REST · RAVEHANDS · ZENCATS | `npm create vite@latest <name> -- --template react-ts` |
| TANS | `npx create-next-app@latest <name> --ts --tailwind --eslint --app --src-dir --use-npm` |

Then add the per-stack pieces (install + minimal wiring):
- **All:** Tailwind v4 (`@tailwindcss/vite` on Vite stacks), shadcn-ui (`npx shadcn@latest init`), `@vercel/analytics`.
- **RATS · REST · RAVEHANDS:** `react-router`.
- **RAVEHANDS · ZENCATS:** Drizzle + Neon (`drizzle-orm`, `drizzle-kit`, `@neondatabase/serverless`; schemas in `src/db/schema/`) + auth.
  - RAVEHANDS auth = hand-rolled (legacy). **ZENCATS auth = passkeys/WebAuthn + TOTP fallback** (no passwords).
- **ZENCATS:** add `zod`, Capacitor (`@capacitor/core`, `@capacitor/cli`), Tauri (`@tauri-apps/cli`).
- **REST:** add Electron (`electron`, `electron-builder`).

Deep stack wiring (auth flows, Capacitor/Tauri native shells, Neon provisioning, Stripe) is **guided, not faked** — set up what installs cleanly headlessly, and record anything that needs accounts or interactive steps as a `## Setup TODO` in the project CLAUDE.md (step 4). Never report a piece as done if it isn't.

### 3. Stamp `<project>/.claude/settings.json`

Create `.claude/` and write:
```json
{
  "permissions": <the "permissions" object from ~/.claude/saved-presets/permissions-<loose|tight>.json>,
  "commitStyle": "<conventional|gitmoji>",
  "automerge": <true|false>,
  "stack": "<STACK>"
}
```
- `permissions`: copy the `permissions` object verbatim from the matching `~/.claude/saved-presets/permissions-*.json`. The harness enforces it natively.
- `commitStyle`, `automerge`, `stack`: read by the build skills (`/branch`, `/preset`) at action time.

### 4. Project CLAUDE.md
Create `<project>/CLAUDE.md` with:
- `**Stack:** <STACK>` + the one-line expansion.
- A one-line config note: `Commit: <style> · Automerge: <on/off>` (human-visible mirror).
- A `## Setup TODO` list for any stack pieces left unfinished in step 2.

### 5. First commit
- `git init`, stage everything, commit following the chosen commit style (read `~/.claude/saved-presets/commit-style-<style>.md` for the format).
- **Zero AI/Claude attribution** anywhere — commit as the developer.

### 6. Report
Name · location · stack · the four config values · any Setup TODOs left for the user.

## Notes
- Source of truth for these four settings is `<project>/.claude/settings.json`. Global fallback defaults live in `~/.claude/` (CLAUDE.md → Defaults).
- To change one later, run `/preset <axis> <value>` inside the project.
