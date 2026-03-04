---
name: lesson-start
description: Session initialization workflow for learning and development
usage: /lesson-start [topic]
examples:
  - /lesson-start
  - /lesson-start authentication
  - /lesson-start database-design
context:
  - .claude/context/learning-progress.md
  - .claude/context/developer-profile.md
  - .claude/output-styles/teaching-mentor.md
allowed-tools:
  - Read
  - Glob
  - Task
---

# Lesson Start Skill

Initializes a new learning or development session with proper context loading and environment preparation.

## Session Initialization Workflow

**The user doesn't need to tell Claude where they left off.** Claude reads the docs and figures it out automatically.

### 1. Check Current State
Read `.claude/context/learning-progress.md` and `.claude/context/curriculum-outline.md` to understand:
- Current learning phase
- Last session's progress
- Immediate next steps
- Any blockers or challenges
- Which concepts are due for review (spaced repetition)

### 2. Verify Environment
Confirm development environment is ready:
- Check if dev server is running (if applicable)
- Verify dependencies are installed
- Ensure clean git state

### 3. Prepare Git Branch
Delegate to git-manager agent if needed:
- Check current branch status
- Create or switch to appropriate branch
- Ensure clean working state

### 4. Set Session Objectives
Based on curriculum and progress:
- Identify 1-3 specific learning goals
- Plan hands-on implementation steps
- Prepare examples to demonstrate

### 5. Load Topic Context
If topic specified, load relevant context:
- Related documentation
- Previous implementations
- Reference materials

## Session Greeting
Start each session with a brief, encouraging greeting that:
- Acknowledges previous progress
- Previews today's objectives
- Sets collaborative, exploratory tone
