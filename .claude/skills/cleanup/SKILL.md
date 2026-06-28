---
name: cleanup
description: /cleanup — cleanup (stash, delete unused branches and worktrees)
usage: /cleanup
examples:
  - /cleanup
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

### 4. Remove Safe Non-Main Worktrees

List worktrees (skip the main one):
```bash
git worktree list --porcelain
```

**For each non-main worktree, check if it's safe to remove.** A worktree is safe only when BOTH are true:

1. **Clean working tree** — no staged, unstaged, or untracked files:
   ```bash
   test -z "$(git -C <worktree-path> status --porcelain)"
   ```
2. **No unpushed commits** — the branch's HEAD matches (or is behind) its upstream, OR the branch is fully reachable from `origin/main`:
   ```bash
   # unpushed commits (empty output = safe on this check)
   git -C <worktree-path> log @{u}..HEAD --oneline 2>/dev/null
   # or, if no upstream, check against origin/main
   git -C <worktree-path> log origin/main..HEAD --oneline
   ```

**Never use `--force`.** If a worktree is not safe, skip it and record why (dirty / unpushed commits / active work in another pane). Report skips in the summary.

For safe worktrees:
```bash
git worktree remove <worktree-path>
```

Prune stale references:
```bash
git worktree prune
```

Then, if `<repo-root>/worktrees/` exists and is now empty, remove it. Leave it alone if any worktrees remain inside.
```bash
rmdir "$(git rev-parse --show-toplevel)/worktrees" 2>/dev/null || true
```

### 5. Report

Print a summary:
- What was stashed (if anything), remind user it's in `git stash list`
- Which branches were deleted (list them)
- Which worktrees were removed (list them)
- Which worktrees were **skipped** and why (dirty / unpushed commits)
- Current state: on `main`, clean working tree, up to date
