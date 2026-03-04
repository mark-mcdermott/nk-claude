# Skills Index

> **Load this first** to see available skills and when to use them.

## Skill Types

| Type | Purpose | Examples |
|------|---------|----------|
| **Workflow** | Execute a multi-step procedure | `/lesson-start`, `/commit`, `/project-init` |
| **Reference** | Load patterns/guidance for use in conversation | `/testing-patterns` |
| **Audit** | Analyze and report on project state | `/docs-audit`, `/progress-review` |

## Available Skills

| Skill | Command | Type | When to Use |
|-------|---------|------|-------------|
| Lesson Start | `/lesson-start` | Workflow | Beginning a learning or development session |
| Progress Review | `/progress-review` | Audit | Spaced repetition review of learned concepts |
| Commit | `/commit` | Workflow | Quick git commits with conversation context |
| Testing Patterns | `/testing-patterns` | Reference | Testing standards reference |
| Educational Workflow | `/educational-workflow` | Workflow | Structured workflow for sessions |
| Docs Audit | `/docs-audit` | Audit | Audit documentation for broken references and orphans |
| Project Init | `/project-init` | Workflow | Scaffold docs and CLAUDE.md for a new project |
| Fresh Clone | `/fresh-clone` | Workflow | Recreate gitignored files after a fresh clone |

## Skill Descriptions

### /project-init
**Purpose**: Scaffold .claude/context/, .learning/, and CLAUDE.md for a new project
**Usage**: `/project-init [project-name]`
**Examples**: `/project-init`, `/project-init hoobie`
**Does**: Interviews you about your background and project, then scaffolds `.claude/context/`, `.learning/`, `CLAUDE.md`, and developer profile with real content

### /fresh-clone
**Purpose**: Recreate gitignored files after a fresh clone
**Usage**: `/fresh-clone`
**Does**: Detects missing gitignored files (like `developer-profile.md`) and walks you through recreating them

### /lesson-start
**Purpose**: Full session initialization
**Usage**: `/lesson-start [topic]`
**Does**: Loads learning progress, identifies next lesson, sets up context

### /progress-review
**Purpose**: Spaced repetition session for reinforcing learned concepts
**Usage**: `/progress-review [focus-area]`
**Does**: Checks progress tracking for concepts due for review, generates questions

### /commit
**Purpose**: Quick git commits that leverage conversation context
**Usage**: `/commit [type]`
**Examples**: `/commit`, `/commit checkpoint`, `/commit experiment`
**Does**: Checks status, stages and commits with context-aware message
**Note**: For complex git operations (conflicts, rebase), delegate to git-manager agent instead

### /testing-patterns
**Type**: Reference
**Purpose**: Testing patterns and standards for projects
**Usage**: `/testing-patterns [type]`
**Does**: Loads testing standards, provides patterns for testing

### /educational-workflow
**Purpose**: Structured workflow patterns for learning and development sessions
**Usage**: `/educational-workflow [phase]`
**Does**: Provides session structure, checkpoint patterns, progress tracking

### /docs-audit
**Purpose**: Audit documentation for broken references, orphaned files, and duplicates
**Usage**: `/docs-audit [scope]`
**Examples**: `/docs-audit`, `/docs-audit agents`, `/docs-audit full`
**Does**: Checks references exist, finds orphaned files, identifies duplicate content

## Proactive Skill Usage

Claude can invoke these skills proactively when:
- Starting a session -> `/lesson-start`
- Before committing -> `/commit`
- When reviewing older concepts -> `/progress-review`
- After major doc changes -> `/docs-audit`
- Starting a new project -> `/project-init`
- After a fresh clone -> `/fresh-clone`
