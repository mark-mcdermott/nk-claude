---
name: educational-workflow
description: Structured workflow patterns for learning and development sessions
usage: /educational-workflow [phase]
examples:
  - /educational-workflow start
  - /educational-workflow implement
  - /educational-workflow close
context:
  - .claude/context/learning-progress.md
allowed-tools:
  - Read
  - Edit
  - Glob
  - Task
  - Skill
---

# Educational Workflow Skill

Provides structured patterns for managing learning and development sessions.

## Quick Patterns

### Learning Session Start
1. Check learning progress for context
2. Delegate to git-manager: create/switch to appropriate branch
3. Plan session objectives with student
4. Load specific context as needed

### Implementation Cycle
1. Explain concept with practical example
2. Build working prototype step-by-step
3. Run tests to verify correctness
4. Git commit with context via /commit
5. Extend example to show variation/complexity

### Session Close
1. Run all tests
2. Git checkpoint via git-manager with milestone tag
3. Update learning progress via documentation agent
4. Preview next session objectives

## Agent Coordination
- **Simple commits**: `/commit` skill (has conversation context)
- **Complex git ops**: git-manager agent (conflicts, rebase, PRs)
- **Progress updates**: documentation agent
- **Complex research**: Task tool with Explore subagent
- **Teaching delivery**: Handled by main agent following `.claude/rules/learning-workflow.md`

## Context Management
- Load modules **on-demand only**
- Delegate liberally to preserve main context
- Keep CLAUDE.md as single source of truth

## Phase-Specific Instructions

### start
Initialize a new session by checking progress status and preparing the development environment.

### implement
Execute the core implementation cycle with testing and commits at each milestone.

### close
Properly close the session with testing, documentation updates, and milestone tags.
