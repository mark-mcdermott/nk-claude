---
name: wd
description: Create a worktree with a database copy and build a feature — full /w lifecycle with isolated database
usage: /wd [branch-name] [feature description]
examples:
  - /wd schema-migration restructure the user table for multi-tenancy
  - /wd fix-payments fix the Stripe webhook handler for failed charges
allowed-tools:
  - Bash(npx:*)
  - Bash(git:*)
  - Bash(gh:*)
  - Bash(npm:*)
  - Bash(node:*)
  - Bash(pg_dump:*)
  - Bash(psql:*)
  - Bash(createdb:*)
  - Bash(dropdb:*)
  - Bash(neonctl:*)
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

# Worktree + Database Copy Build Skill

Exactly like `/w` (full lifecycle in a worktree), but also creates a copy of the database. All work uses the copy — the original database is never touched. **Never ask the user for details or confirmation.**

## Workflow

### 1. Create Worktree

Same as `/w` step 1 — parse arguments, create worktree, save `REPO_DIR` and `WORKTREE_PATH`, install dependencies.

### 2. Copy Database

Detect the database configuration from the worktree:
```bash
cd <WORKTREE_PATH> && cat .env .env.local 2>/dev/null | grep -iE "database|db_|postgres|neon"
```

Create a copy based on the database type:

#### Local PostgreSQL
```bash
SOURCE_DB="<detected-db-name>"
COPY_DB="${SOURCE_DB}_copy_$(echo <branch-name> | tr '/-' '_')"

createdb "$COPY_DB"
pg_dump "$SOURCE_DB" | psql "$COPY_DB"
```

#### Neon (serverless)
```bash
# Create a Neon branch (isolated database copy)
neonctl branches create --name "<branch-name>" --project-id <project-id>
# Capture the new connection string from the output
```

#### SQLite
```bash
cp <WORKTREE_PATH>/<db-file> <WORKTREE_PATH>/<db-file>.copy
```

Update the worktree's environment to point to the copy:
```bash
# Edit .env.local in the WORKTREE only
```
Use the `Edit` tool on `<WORKTREE_PATH>/.env.local` to swap the database connection string.

**CRITICAL**: Only modify env files in the WORKTREE, never the original repo.

Save `COPY_DB` (or connection string) for cleanup.

### 3. Execute Full /w Workflow

Follow **every step** of the `/w` skill (which follows `/b`), using the copy database.

All worktree path rules from `/w` apply. All implementation rules from `/b` apply.

All database operations — migrations, seeds, queries — run against the copy.

### 4. Delete Copy Database

After implementation is complete and tests pass, but **before** the PR/merge steps:

#### Local PostgreSQL
```bash
dropdb "$COPY_DB"
```

#### Neon
```bash
neonctl branches delete --project-id <project-id> <branch-id>
```

#### SQLite
```bash
rm <WORKTREE_PATH>/<db-file>.copy
```

### 5. Continue /w Cleanup

Complete the remaining `/w` steps: PR (no AI attribution), merge (handle conflicts), checkout main, delete branch, remove worktree.

Report to the user: what was built, tests passing, database copy deleted, PR merged, worktree cleaned up.
