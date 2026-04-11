---
name: w
description: Create a worktree and build a feature — full /b lifecycle in an isolated worktree
usage: /w [branch-name] [feature description]
examples:
  - /w login-fix fix the login redirect loop on expired sessions
  - /w merch-store add a merch store page with product grid
  - /w add dark mode toggle to the settings panel
allowed-tools:
  - Bash(npx:*)
  - Bash(git:*)
  - Bash(gh:*)
  - Bash(npm:*)
  - Bash(node:*)
  - Read
  - Edit
  - Write
  - Glob
  - Grep
  - Agent
  - TaskCreate
  - TaskUpdate
  - TaskGet
  - WebFetch
---

# Worktree Build Skill

Exactly like `/b` (full lifecycle: design, TDD, security review, code review, QA, PR, merge, cleanup), but all work happens in an isolated git worktree. **Never ask the user for details or confirmation.**

## Worktree Path Rules (CRITICAL)

**Read these before every file operation. Re-read after context compression.**

After creating the worktree, ALL work MUST happen in the worktree directory:

- **Bash commands**: Always prefix with `cd <WORKTREE_PATH> &&`
- **Read/Edit/Write/Glob/Grep**: Always use absolute paths under `<WORKTREE_PATH>/`
- **NEVER** operate on files in the original repo directory

**Self-check before every operation**: Does this path start with `WORKTREE_PATH`? If not, STOP and correct.

## Workflow

### 1. Create Worktree

Parse arguments the same way as `/b` (first word = branch name if slug-like, rest = feature description).

Infer the prefix (`feat/`, `fix/`, `refactor/`) from the feature description if none given.

```bash
REPO_DIR=$(pwd)
PARENT_DIR=$(dirname "$REPO_DIR")
BRANCH_NAME="<prefix>/<branch-name>"
WORKTREE_PATH="$PARENT_DIR/<branch-name>"
git worktree add "$WORKTREE_PATH" -b "$BRANCH_NAME"
```

Save both `REPO_DIR` and `WORKTREE_PATH` — you need both for cleanup.

Install dependencies in the worktree:
```bash
cd "$WORKTREE_PATH" && npm install
```

### 2. Execute Full /b Workflow

Follow **every step** of the `/b` skill (Explore & Prepare → Design → Plan → TDD Cycle → Security Review → Code Review → QA Cycle → Finalize), with these modifications:

- **Skip** the "Create Branch" step — the branch was already created by `git worktree add`
- **Every** `git` command: `cd <WORKTREE_PATH> && git ...`
- **Every** file path: absolute under `<WORKTREE_PATH>/`
- **Every** `npx`/`npm`/`node` command: `cd <WORKTREE_PATH> && ...`
- **Cleanroom check**: resolve relative to worktree root
- **Progress file**: `<WORKTREE_PATH>/.claude/b-progress.md`

All **Implementation Rules** from `/b` apply identically.

The commit style cascade is the same:
1. `<WORKTREE_PATH>/.claude/commit-style.md`
2. `~/.claude/defaults/commit-style.md`
3. Conventional commits (fallback)

### 3. PR, Merge, and Branch Cleanup

These steps happen the same as `/b` — push, create PR (no AI attribution), merge (handle conflicts), checkout main, delete branch.

All git commands still prefixed with `cd <WORKTREE_PATH> &&` until the worktree is removed.

### 4. Clean Up Worktree

After the PR is merged and branch is deleted:

```bash
cd <REPO_DIR>
git worktree remove "$WORKTREE_PATH"
```

If removal fails:
```bash
git worktree remove --force "$WORKTREE_PATH"
```

Verify:
```bash
git worktree list
```

Report to the user: what was built, tests passing, PR merged, worktree cleaned up.

If new UI components were created, note Cleanroom contribution candidates.
