---
name: worktree
description: /worktree <branch> <feature> — same as /branch but in an isolated worktree
usage: /worktree <branch> <feature>
examples:
  - /worktree login-fix fix the login redirect loop on expired sessions
  - /worktree merch-store add a merch store page with product grid
  - /worktree add dark mode toggle to the settings panel
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

Exactly like `/branch` (full lifecycle: design, TDD, security review, code review, QA, PR, (auto)merge, cleanup), but all work happens in an isolated git worktree. **Never ask the user for details or confirmation.**

## Worktree Path Rules (CRITICAL)

**Read these before every file operation. Re-read after context compression.**

After creating the worktree, ALL work MUST happen in the worktree directory:

- **Bash commands**: Always prefix with `cd <WORKTREE_PATH> &&`
- **Read/Edit/Write/Glob/Grep**: Always use absolute paths under `<WORKTREE_PATH>/`
- **NEVER** operate on files in the original repo directory

**Self-check before every operation**: Does this path start with `WORKTREE_PATH`? If not, STOP and correct.

## Workflow

### 1. Create Worktree

Parse arguments the same way as `/branch` (first word = branch name if slug-like, rest = feature description).

Infer the prefix (`feat/`, `fix/`, `refactor/`) from the feature description if none given.

```bash
REPO_DIR=$(git rev-parse --show-toplevel)
WORKTREES_DIR="$REPO_DIR/worktrees"
BRANCH_NAME="<prefix>/<branch-name>"
WORKTREE_PATH="$WORKTREES_DIR/<branch-name>"
mkdir -p "$WORKTREES_DIR"
git worktree add "$WORKTREE_PATH" -b "$BRANCH_NAME"
```

Worktrees always live in `<repo-root>/worktrees/<branch-name>`. Create the `worktrees/` directory if it doesn't exist.

Save both `REPO_DIR` and `WORKTREE_PATH` — you need both for cleanup.

Install dependencies in the worktree:
```bash
cd "$WORKTREE_PATH" && npm install
```

### 2. Execute Full /branch Workflow

Follow **every step** of the `/branch` skill (Explore & Prepare → Design → Plan → TDD Cycle → Security Review → Code Review → QA Cycle → Finalize), with these modifications:

- **Skip** the "Create Branch" step — the branch was already created by `git worktree add`
- **Every** `git` command: `cd <WORKTREE_PATH> && git ...`
- **Every** file path: absolute under `<WORKTREE_PATH>/`
- **Every** `npx`/`npm`/`node` command: `cd <WORKTREE_PATH> && ...`
- **Progress file**: `<WORKTREE_PATH>/.claude/branch-progress.md`

All **Implementation Rules** from `/branch` apply identically.

Commit style is the same as `/branch`: read `commitStyle` from `<WORKTREE_PATH>/.claude/settings.json` (`conventional` if absent), then its format from `~/.claude/saved-presets/commit-style-<style>.md`.

### 3. PR, (Auto)Merge, and Branch Cleanup

These steps happen the same as `/branch` — push and create the PR (no AI attribution), then honor the project's `automerge` setting (read from `<WORKTREE_PATH>/.claude/settings.json`, default `false`): if `false`, **stop and report the open PR** (leave the worktree in place for review); if `true`, merge (handle conflicts), checkout main, delete branch.

All git commands still prefixed with `cd <WORKTREE_PATH> &&` until the worktree is removed.

### 4. Clean Up Worktree

After the PR is merged and branch is deleted (only when `automerge` is on — if off, leave the worktree for the user to clean up after review):

```bash
cd "$REPO_DIR"
git worktree remove "$WORKTREE_PATH"
```

If removal fails:
```bash
git worktree remove --force "$WORKTREE_PATH"
```

Then remove the `worktrees/` directory **only if it is now empty** (i.e., this was the last remaining worktree). If other worktrees still exist in there, leave the directory alone.

```bash
rmdir "$WORKTREES_DIR" 2>/dev/null || true
```

Verify:
```bash
git worktree list
```

Report to the user: what was built, tests passing, and — if `automerge` was on — PR merged and worktree cleaned up.
