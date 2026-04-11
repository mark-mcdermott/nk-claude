---
name: skills
description: /skills — list all custom skills
usage: /skills
examples:
  - /skills
allowed-tools:
  - Glob
  - Read
---

# List Skills

List all custom skills installed in the project's `.claude/skills/` directory. Print each skill's name and one-line description.

## Workflow

### 1. Find All Skills

Use `Glob` to find all `SKILL.md` files under `.claude/skills/`:
```
.claude/skills/*/SKILL.md
```

### 2. Read Each Skill

For each `SKILL.md`, read just the frontmatter (the YAML between the `---` delimiters). Extract:
- `name`
- `description`

### 3. Print the List

Print a compact table, sorted alphabetically by name:

```
Skill             Description
─────             ───────────
/a                Abandon the current branch — stash, switch to main, delete branch
/b                Create a branch and build a feature — full lifecycle
...
```

No other output. No suggestions, no commentary — just the list.
