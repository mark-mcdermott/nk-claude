---
name: one-shot
description: Build an entire project from a checklist, TDD-style, autonomously — only return when everything is done
usage: /one-shot <checklist or path to checklist file>
examples:
  - /one-shot build a todo app with auth, CRUD todos, and filtering
  - /one-shot CHECKLIST.md
allowed-tools:
  - Bash(npx:*)
  - Bash(git:*)
  - Bash(npm:*)
  - Bash(node:*)
  - Read
  - Edit
  - Write
  - Glob
  - Grep
  - Agent
  - TaskCreate
  - TaskUpdate
  - TaskGet
---

# One-Shot Skill

Autonomously build an entire project from a checklist. Each feature is built TDD-style with Playwright. Work is committed and documented as you go. Only return to the user when the full checklist is complete — or if truly blocked.

## Workflow

### 1. Parse the Checklist

If the argument is a file path, read it. Otherwise, parse the feature list from the argument text.

Break the project into discrete, ordered features. Each feature should be independently testable. If the user provided a checklist, respect their ordering. If not, order by dependency (foundational pieces first).

### 2. Create Tasks

Use `TaskCreate` for each feature in the checklist. This is critical — tasks survive context compression and keep you on track.

### 3. Initialize Progress File

**If `.claude/one-shot-progress.md` already exists**, back it up before starting fresh:
```bash
mkdir -p .claude/one-shot-progress-bak
mv .claude/one-shot-progress.md ".claude/one-shot-progress-bak/one-shot-progress-bak-$(date +%m-%d-%y-%H-%M-%S).md"
```

Write the initial progress file:

```markdown
# One-Shot Progress

## Checklist
- [ ] Feature 1
- [ ] Feature 2
- ...

## Completed Features

(none yet)

## Current State
Starting build.
```

Save to `.claude/one-shot-progress.md`.

### 4. Ensure Playwright is Ready
```bash
npx playwright --version
```
If not installed:
```bash
npm install -D @playwright/test && npx playwright install
```
Check for existing `playwright.config.ts`. If none exists, create a sensible default.

### 5. For Each Feature — TDD Cycle

Before starting each feature, **re-read `.claude/one-shot-progress.md`** to re-orient (this is essential after context compression).

Then update the task status to `in_progress` and follow this cycle:

#### a. Write the Test (RED)
- Write a Playwright test for the feature
- Follow existing test conventions in the project

#### b. Confirm Failure
```bash
npx playwright test <test-file> --reporter=list
```
- Must fail. If it passes, the test isn't testing anything new.

#### c. Build the Feature (GREEN)
- Implement the minimum to make the test pass
- Follow existing project patterns

#### d. Confirm Pass
```bash
npx playwright test <test-file> --reporter=list
```
- If it fails, fix and rerun. Do not weaken the test.
- If it passes, continue.

#### e. Run Full Test Suite
```bash
npx playwright test --reporter=list
```
- Ensure nothing else broke. Fix regressions before moving on.

#### f. Commit
```bash
git add [relevant files]
git commit -m ":sparkles: Add [feature name]"
```
Commit after each passing feature. This protects work and keeps diffs small.

**Commit rules (CRITICAL)**:
- One gitmoji + one sentence. No bullet lists, no multiline bodies.
- No AI attribution. No co-author lines, no signatures, no references to Claude/AI.

#### g. Update Progress

Mark the task as `completed`.

Update `.claude/one-shot-progress.md`:
- Check off the feature in the checklist
- Add an entry under "Completed Features" with a brief note on what was built and any key decisions
- Update "Current State" to reflect what's next

### 6. Final Steps

After all features are complete:

1. Run the full test suite one final time
2. Update progress file with final status
3. Delete `.claude/one-shot-progress.md` (it's served its purpose)
4. Report to the user:
   - What was built (brief summary)
   - All tests passing
   - Number of commits made
   - Any decisions or trade-offs worth noting

## Rules

- **Do not return to the user mid-build** unless genuinely blocked (ambiguous requirement, missing credentials, external dependency you can't resolve). If something is unclear but you can make a reasonable default choice, do that and note it in the progress file.
- **Re-read the progress file before each feature.** This is your lifeline after context compression.
- **Commit after every passing feature.** Never accumulate more than one feature's worth of uncommitted work.
- **Never weaken a test to make it pass.** Fix the implementation. Exception: genuine test bugs (wrong selector, typo).
- **Run the full suite after each feature**, not just the new test. Catch regressions early.
- **Keep the progress file concise.** It needs to fit in context — no verbose logs. Key decisions and current state only.
- **If the dev server needs to be running**, start it in the background or configure `webServer` in `playwright.config.ts`.

## Gitmoji Reference

| Type | Gitmoji | When |
|------|---------|------|
| New feature | `:sparkles:` | Adding new functionality |
| Bug fix | `:bug:` | Fixing broken behavior |
| Refactor | `:recycle:` | Restructuring without behavior change |
| Config/chore | `:wrench:` | Configuration or setup changes |
| Tests | `:white_check_mark:` | Test-only changes |
| Initial commit | `:tada:` | Project scaffolding |
