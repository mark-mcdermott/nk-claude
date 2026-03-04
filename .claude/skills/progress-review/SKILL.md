---
name: progress-review
description: Spaced repetition session review for reinforcing learned concepts
usage: /progress-review [focus-area]
examples:
  - /progress-review
  - /progress-review architecture
  - /progress-review testing
context:
  - .claude/context/learning-progress.md
allowed-tools:
  - Read
  - Edit
  - Glob
---

# Progress Review Skill

Implements spaced repetition principles to review and reinforce previously learned concepts.

## Review Session Structure

### 1. Load Current Progress
Read learning progress to understand:
- Current learning phase
- Skills marked as completed
- Recent challenges encountered
- Upcoming objectives

### 2. Identify Review Candidates
Based on spaced repetition principles, identify concepts for review:
- **Recently learned** (1-3 days): Quick recall check
- **Medium-term** (1-2 weeks): Application exercises
- **Long-term** (1+ month): Integration challenges

### 3. Generate Review Questions
For each concept, create questions that test:
- **Recall**: Can student explain the concept?
- **Recognition**: Can student identify correct usage?
- **Application**: Can student use it in new context?
- **Connection**: Can student relate to other concepts?

### 4. Conduct Review
Present questions conversationally:
- Start with recall questions
- Progress to application challenges
- Note areas of strength and weakness
- Provide immediate, constructive feedback

### 5. Update Progress Tracking
Document review outcomes:
- Concepts reinforced successfully
- Areas needing additional practice
- Adjusted review schedule

## Spaced Repetition Schedule
- Day 1: Initial learning
- Day 2: First review
- Day 4: Second review
- Week 2: Third review
- Month 1: Fourth review
- Month 3: Maintenance review
