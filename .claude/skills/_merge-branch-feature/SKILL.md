---
name: _merge-branch-feature
description: Commit and PR the current branch, switch to main, then create a new branch and build a feature
usage: /baf <branch-name> <feature description> (after finishing previous feature)
examples:
  - /baf merch-store add a merch store page with product grid
allowed-tools:
  - Bash(git:*)
  - Bash(gh:*)
  - Read
  - Edit
  - Write
  - Glob
  - Grep
  - Agent
  - Skill
---

# Merge + Branch and Feature

Wrap up the current branch (commit, push, PR), switch to main, then create a new branch and start building a feature.

## Workflow

### 1. Merge Current Work

Use the Skill tool to invoke `_commit-and-pr` to commit, push, and create a PR for the current branch.

### 2. Switch to Main

```bash
git checkout main
git pull origin main
```

### 3. Branch and Feature

Use the Skill tool to invoke `_branch-and-feature` with the same arguments passed to this skill.
