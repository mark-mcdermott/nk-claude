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
  - Bash(gh:*)
  - Read
---

# Commit Skill

Quick commits that leverage conversation context. For complex git operations (merge conflicts, rebasing, branch strategy), delegate to git-manager agent instead.

## When to Use

| Situation | Use This | Use git-manager Agent |
|-----------|----------|----------------------|
| Simple commit after work | yes | no |
| Checkpoint/milestone | yes | no |
| Merge conflict | no | yes |
| Rebase/history rewrite | no | yes |
| Branch strategy decisions | no | yes |

## Quick Workflow

### 1. Check Status
```bash
git status
git diff --stat
```

### 2. Run Pre-Commit Checks
Run your project's lint and test commands before committing.

### 3. Stage & Commit
```bash
git add [files]
git commit -m "$(cat <<'EOF'
type: subject - brief description

- Key change 1
- Key change 2
EOF
)"
```

### 4. Push
```bash
git push origin [current-branch]
```

## Commit Types

| Type | When to Use |
|------|-------------|
| `learn` | New concept or skill demonstrated |
| `feat` | New feature or functionality |
| `fix` | Bug fix |
| `refactor` | Code improvement without behavior change |
| `docs` | Documentation updates |
| `checkpoint` | Major milestone completion |
| `experiment` | Exploratory work (may fail) |

## Message Guidelines

- **Use conversation context**: You know what was just discussed/built
- **Keep it concise**: 1-2 sentence summary, bullet points for details
- **Match branch type**: `learn/*` branches get `learn:` commits
- **No AI attribution**: Do not add co-author lines or reference Claude

## PR Workflow Integration

After committing, if the work represents a complete unit (feature done, bug fixed, lesson complete), create a PR:

### When to Create a PR
- Feature branch has a complete, working feature
- Fix branch resolves the issue
- Learning branch completes a milestone or lesson
- **Do NOT create PRs for partial/in-progress work** -- just commit and push

### Creating a PR
```bash
gh pr create --title "type: brief description" --body "$(cat <<'EOF'
## Summary
- What was done and why

## Changes
- Key change 1
- Key change 2

## Testing
- How it was tested

## Review Notes
Please review carefully before merging. Check for:
- [ ] Code correctness and edge cases
- [ ] No hardcoded secrets or credentials
- [ ] Tests pass
- [ ] Linting passes
EOF
)"
```

### After Creating a PR
- **Always** tell the user the PR URL
- **Always** ask the user to review the code carefully before merging
- **Never** merge PRs automatically -- the user must approve and merge
- Suggest specific things to look at during review based on what changed
