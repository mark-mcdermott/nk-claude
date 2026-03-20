---
name: commit
description: Quick git commits with conversation context
usage: /commit [type]
examples:
  - /commit
  - /commit checkpoint
  - /commit experiment
allowed-tools:
  - Bash(git:*)
  - Read
---

# Commit Skill

Quick commits that leverage conversation context. Just stage, commit, and push — no PR creation. Use `/cap` when the work is done and needs a PR.

## Workflow

### 1. Pre-Commit Checks
Run the project's typecheck, lint, and test commands (check package.json or project config for available scripts).
Fix any issues before proceeding.

### 2. Check Status & Stage
```bash
git status
git diff --stat
git add [files]
```

### 3. Commit
Write a gitmoji + one-sentence commit message based on the conversation context.
```bash
git commit -m ":sparkles: Add merch store page with product grid and cart"
```

**Commit rules (CRITICAL)**:
- One gitmoji + one sentence. No bullet lists, no multiline bodies.
- No AI attribution. No co-author lines, no signatures, no references to Claude/AI.
- Commit as the developer, never as Claude.

### 4. Push
```bash
git push origin [current-branch]
```

If the branch has no upstream yet, use `git push -u origin [branch]`.

## Gitmoji Reference

| Type | Gitmoji | When |
|------|---------|------|
| New feature | `:sparkles:` | Adding new functionality |
| Bug fix | `:bug:` | Fixing broken behavior |
| Refactor | `:recycle:` | Restructuring without behavior change |
| Style/UI | `:lipstick:` | Visual/styling changes |
| Performance | `:zap:` | Performance improvements |
| Tests | `:white_check_mark:` | Adding or updating tests |
| Config/chore | `:wrench:` | Configuration changes |
| Cleanup | `:fire:` | Removing code or files |
| Docs | `:memo:` | Documentation updates |
| Learning | `:seedling:` | New concept or skill demonstrated |
| Checkpoint | `:triangular_flag_on_post:` | Major milestone completion |
| Experiment | `:alembic:` | Exploratory work |
