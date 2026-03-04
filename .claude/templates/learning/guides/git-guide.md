# Git Guide

## Core Principles

### Learning-First Commits
- Commit after understanding each concept, not just after working features
- Include "why" explanations in commit messages
- Small, logical commits that show progression

### PR-Based Workflow
- All code reaches `main` through pull requests -- never direct commits
- PRs force you to review your own code before merging
- Claude creates the PR, you review and merge
- This teaches professional development workflow

### Safe Experimentation
- Use experiment branches for exploration
- Never fear breaking things -- git keeps everything safe
- Easy recovery from failed experiments

## Branch Strategy

### Core Branches

#### `main`
- **Purpose**: Production-ready code only
- **Protection**: Protected branch -- no direct commits
- **Merge Source**: Only via pull requests

### Working Branches

#### `feat/[name]`
- **Purpose**: New functionality
- **Duration**: Until feature is complete
- **Merge Target**: main (via PR)

#### `fix/[issue]`
- **Purpose**: Bug fixes
- **Merge Target**: main (via PR)

#### `learn/[topic]`
- **Purpose**: Learning and experimentation with a topic
- **Duration**: 1-2 weeks typically
- **Merge Target**: main (via PR after milestone)

#### `experiment/[topic]`
- **Purpose**: Safe exploration, may fail
- **Merge Strategy**: Cherry-pick successful parts, or PR if the whole experiment worked

## Development Flow

```
1. Create branch    git checkout -b feat/my-feature
2. Work & commit    /commit (frequent, small commits)
3. Push             git push origin feat/my-feature
4. Create PR        gh pr create (Claude does this)
5. Review           YOU review the PR on GitHub
6. Merge            YOU merge the PR on GitHub
7. Clean up         git checkout main && git pull && git branch -d feat/my-feature
```

### When to Create a PR
- Feature branch has a complete, working feature
- Fix branch resolves the issue
- Learning branch completes a milestone
- **Don't PR partial/in-progress work** -- just commit and push

### PR Review Checklist
Before merging, check:
- [ ] Code does what it's supposed to
- [ ] No hardcoded secrets or credentials
- [ ] Tests pass
- [ ] Linting passes
- [ ] No unnecessary files committed
- [ ] Commit messages are clear

## Commit Message Standards

### Format
```
[type]: [subject] - [brief description]

[Optional longer explanation]
```

### Types
- **learn**: New concept mastery or skill development
- **feat**: New feature or functionality
- **fix**: Bug fix
- **refactor**: Code improvement without behavior change
- **docs**: Documentation updates
- **checkpoint**: Major milestone completion
- **experiment**: Exploratory work

### Examples
```
feat: add user authentication - JWT-based login flow

Implemented JWT auth with refresh tokens. Passwords hashed with bcrypt.
Sessions stored in httpOnly cookies for security.
```

```
learn: database design - normalized schema for projects

Designed 3NF schema for projects, goals, and steps.
Learned about junction tables for many-to-many relationships.
```

## Daily Workflow

```bash
# Start session
git checkout feat/[current-feature]
git pull origin feat/[current-feature]

# Work and commit frequently
git add [files]
git commit -m "type: subject - description"

# End session -- push work
git push origin feat/[current-feature]

# When feature is complete -- create PR
gh pr create --title "feat: description" --body "summary of changes"
# Then review and merge the PR on GitHub
```

## Error Recovery

### Experimental Branch Gone Wrong
```bash
git checkout main
git branch -D experiment/[failed-topic]
git checkout -b experiment/[new-approach]
```

### Accidental Commit on Wrong Branch
```bash
git reset --soft HEAD~1        # Undo commit, keep changes
git stash                      # Stash the changes
git checkout correct-branch
git stash pop                  # Apply changes here
git add . && git commit -m "..."
```

### Finding Lost Commits
```bash
git reflog                     # Shows all recent HEAD movements
git checkout [commit-hash]     # Inspect the lost commit
```
