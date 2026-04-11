---
name: _merge-branch-feature-one-shot
description: Commit and PR the current branch, switch to main, then create a branch and one-shot a project
usage: /baos <branch-name> <checklist or path> (after finishing previous work)
examples:
  - /baos todo-app build a todo app with auth, CRUD todos, and filtering
allowed-tools:
  - Bash(git:*)
  - Bash(gh:*)
  - Bash(npx:*)
  - Bash(npm:*)
  - Bash(node:*)
  - Read
  - Edit
  - Write
  - Glob
  - Grep
  - Agent
  - Skill
  - TaskCreate
  - TaskUpdate
  - TaskGet
---

# Merge + Branch and One-Shot

Wrap up the current branch (commit, push, PR), switch to main, then create a new branch and one-shot a project.

## Workflow

### 1. Merge Current Work

Use the Skill tool to invoke `_commit-and-pr` to commit, push, and create a PR for the current branch.

### 2. Switch to Main

```bash
git checkout main
git pull origin main
```

### 3. Branch and One-Shot

Use the Skill tool to invoke `baos` with the same arguments passed to this skill.
