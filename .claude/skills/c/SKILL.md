---
name: c
description: Stash uncommitted work, delete unused branches, and remove unused worktrees
usage: /c
examples:
  - /c
allowed-tools:
  - Bash(git:*)
---

# Cleanup Skill

Tidy up the local repo: stash uncommitted files, delete all branches except main, and remove unused worktrees. Fully autonomous — no confirmation needed.

## Workflow

### 1. Stash Uncommitted Work

```bash
git status --porcelain
```

If there are any changes (staged, unstaged, or untracked):
```bash
git stash push -u -m "cleanup: auto-stash $(date +%Y-%m-%d-%H%M%S)"
```

The `-u` flag includes untracked files.

### 2. Switch to Main

```bash
git checkout main
git pull origin main
```

### 3. Delete All Non-Main Branches

```bash
git branch --list | grep -v '^\*' | grep -v 'main' | grep -v 'master'
```

Delete each one:
```bash
git branch -D <branch-name>
```

**Only local branches.** Do not touch remote branches.

### 4. Remove All Non-Main Worktrees

```bash
git worktree list
```

For every worktree that is NOT the main working tree (the first entry, or the one matching the repo root):
```bash
git worktree remove <worktree-path>
```

If removal fails (uncommitted changes in worktree):
```bash
git worktree remove --force <worktree-path>
```

Prune stale references:
```bash
git worktree prune
```

### 5. Report

Print a summary:
- What was stashed (if anything), remind user it's in `git stash list`
- Which branches were deleted (list them)
- Which worktrees were removed (list them)
- Current state: on `main`, clean working tree, up to date
