---
name: docs-audit
description: Audit documentation architecture for proper information partitioning
usage: /docs-audit [scope]
examples:
  - /docs-audit
  - /docs-audit agents
  - /docs-audit skills
  - /docs-audit full
context:
  - CLAUDE.md
  - .claude/agents/README.md
  - .claude/skills/README.md
allowed-tools:
  - Glob
  - Grep
  - Read
  - Write
  - Edit
  - Bash(ls:*)
  - Bash(mkdir:*)
  - Task
---

# Documentation Audit Skill

Audits the documentation architecture to ensure each context (agent, skill, output style) has access to exactly the information it needs -- no more, no less.

## Philosophy

Good documentation architecture means:
- **Each context is self-sufficient** for its specific job
- **No unnecessary loading** of irrelevant information
- **Clear hierarchy** where specialized contexts reference authoritative sources
- **No duplication** that could drift out of sync
- **Discoverable paths** from entry points to needed information

## Audit Execution

**This skill uses subagents** to deeply analyze each context type.

### Scope Options

| Scope | Subagents Spawned |
|-------|-------------------|
| (default) | Entry point analysis only |
| `agents` | One subagent per agent file |
| `skills` | One subagent per skill file |
| `output-styles` | One subagent for output styles |
| `full` | All of the above + cross-cutting analysis |

## Per-Context Analysis

For each agent/skill/style, evaluate:

### 1. Information Accessibility
Can this context reach everything it needs to do its job?

### 2. Information Efficiency
Does this context load only what it needs?

### 3. Source of Truth
Does this context define things it shouldn't, or properly defer?

### 4. Self-Containment
Can this context operate independently or does it have hidden dependencies?

## Output Format

```markdown
## Documentation Architecture Audit

### Executive Summary
- Contexts analyzed: X
- Well-partitioned: X
- Needs attention: X
- Critical issues: X

### Per-Context Findings

#### [context-name]
**Purpose**: [what it does]
**Verdict**: Well-partitioned | Needs attention | Critical issues

| Aspect | Status | Finding |
|--------|--------|---------|
| Accessibility | ok/warn/error | [can reach what it needs?] |
| Efficiency | ok/warn/error | [loads only what it needs?] |
| Source of Truth | ok/warn/error | [defers appropriately?] |
| Self-Containment | ok/warn/error | [declares all dependencies?] |

### Priority Fixes
1. [Critical] ...
2. [High] ...
3. [Medium] ...
```

## Registration Validation

### Skills Validation Checklist
For each skill directory in `.claude/skills/*/SKILL.md`:
1. **File exists**: Does `SKILL.md` exist in the directory?
2. **Frontmatter valid**: Does it have `name`, `description`, `usage` fields?
3. **Registered in README**: Is it listed in `.claude/skills/README.md`?
4. **Registered in CLAUDE.md**: Is it listed in the Skills table?

### Agents Validation Checklist
For each agent file in `.claude/agents/*.md` (excluding README.md):
1. **Registered in README**: Is it listed in `.claude/agents/README.md`?
2. **Registered in CLAUDE.md**: Is it listed in Agent Delegation section?

## Classification Criteria

**Should be AGENT when:**
- Task requires fresh context
- Work should be offloaded
- Output is a single result returned to main conversation

**Should be SKILL when:**
- Task is a repeatable workflow
- Needs conversation context
- User should be able to invoke by command

**Should be RULES/OUTPUT STYLE when:**
- Defines behavior patterns that apply throughout conversation
- Should be always active, not invoked on demand

## When to Run

| Trigger | Scope | Why |
|---------|-------|-----|
| Monthly maintenance | `full` | Catch drift before it accumulates |
| After adding agent/skill | `agents` or `skills` | Verify new context is well-integrated |
| After major refactor | `full` | Ensure partitioning wasn't broken |
| Before milestone | (default) | Quick sanity check |
