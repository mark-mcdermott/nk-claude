---
name: commit-push-on-main
description: Commit changes, merge to main if needed, and push
usage: /commit-push-on-main
examples:
  - /commit-push-on-main
  - /cpom
allowed-tools:
  - Bash(git:*)
  - Read
---

# Commit Push on Main

Commit current changes and get them onto main. If already on main, just commit and push. If on a feature branch, commit, switch to main, merge the branch, and push.

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

### 4. Get to Main and Push

Determine the current branch:
```bash
git branch --show-current
```

**If already on `main`:**
```bash
git push origin main
```

**If on a feature branch:**
```bash
git checkout main
git merge [branch-name]
git push origin main
```

After pushing, report success to the user.

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
