# Agents & Consultants Index

> **Load this first** to determine how to get help.

## Two Types of Helpers

### Agents (Delegate via Task tool)
Execute multi-step workflows in fresh context. Use when work should be **offloaded**.

| Agent | Delegate When | How |
|-------|---------------|-----|
| `git-manager.md` | Complex git (conflicts, rebase, PRs, branch strategy) | Task tool |
| `documentation.md` | Updating docs, maintaining learning progress | Task tool |
| `debugger.md` | Bugs, console errors, systematic debugging | Task tool or Teammate |

> **Git Routing**: Simple commits use `/commit` skill (has conversation context). Only delegate to git-manager for complex operations.

## Decision Tree

```
Need to do git operations?
  |-> Read-only (status/log/diff)?
  |     -> Execute directly
  |-> Simple commit?
  |     -> /commit skill (keeps conversation context)
  --> Complex (conflicts/rebase/PRs)?
        -> DELEGATE to git-manager.md

Need to update documentation?
  -> DELEGATE to documentation.md

Need to debug a bug or check application state?
  -> DELEGATE or SPAWN TEAMMATE from debugger.md
```

## When to Delegate vs Handle Inline

| Scenario | Use Agent (Delegate) | Handle Inline |
|----------|---------------------|---------------|
| Multi-step workflow with state | yes | no |
| Need fresh context | yes | no |
| Quick fix or simple question | no | yes |
| Need conversation history | no | yes |
| Can run in parallel with other work | yes | no |

---

## Agents (Detailed)

### git-manager.md
**Type**: Agent (delegate via Task tool)
**Why Agent**: Complex git operations need focused attention and fresh context

**Use for** (complex operations):
- Merge conflict resolution
- Rebase/history rewriting
- Branch strategy decisions
- PR creation and management
- Repository initialization

**Don't use for** (use `/commit` skill instead):
- Simple commits after work
- Checkpoint/milestone commits

### documentation.md
**Type**: Agent (delegate via Task tool)
**Why Agent**: Coordinates updates across multiple files

- Updating learning-progress.md
- Maintaining curriculum completion status
- Recording decisions and rationale
- Coordinating doc updates with code changes

### debugger.md
**Type**: Agent (delegate via Task tool) or Teammate (spawn for collaborative sessions)
**Why Agent/Teammate**: Debugging requires focused context -- reading code, checking state, isolating issues.

- Application bugs and errors
- Console errors and warnings
- Systematic issue isolation and minimal fixes
- Can run as a one-shot agent or as an ongoing teammate for extended sessions

**As Teammate**: Spawn for extended debugging sessions where back-and-forth is needed. Reports findings, proposes fixes, waits for approval.

---

## Classification Criteria

**Should be AGENT when:**
- Task requires fresh context (deep research, complex multi-step work)
- Work should be offloaded to preserve main conversation focus
- Output is a single result returned to main conversation
- Task is self-contained and doesn't need conversation history
- Benefits from parallel execution with other work

**Should be CONSULTANT when:**
- Task is providing expert advice or decision guidance
- Needs conversation context to give relevant advice
- Main agent should implement the advice (not delegate implementation)
- Guidance applies to current work, not a separate workflow
