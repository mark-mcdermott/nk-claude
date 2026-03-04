---
name: fresh-clone
description: Recreate gitignored files after a fresh clone
usage: /fresh-clone
examples:
  - /fresh-clone
allowed-tools:
  - Read
  - Write
  - Edit
  - Glob
  - Bash(ls:*)
  - Bash(mkdir:*)
  - AskUserQuestion
---

# Fresh Clone Skill

Recreates gitignored files that are missing after a fresh `git clone`. These files contain personal or sensitive information that shouldn't live in the repo.

## When to Use

Run this after cloning the project repo on a new machine, or if gitignored files were deleted. Claude can also detect missing files and suggest running this automatically.

## Workflow

### 1. Detect Missing Files

Check for gitignored files that should exist:

| File | Purpose | Required |
|------|---------|----------|
| `.claude/context/developer-profile.md` | Developer background, skills, accessibility needs | Yes |

If all files exist, report that and exit -- nothing to do.

### 2. Recreate Developer Profile

If `.claude/context/developer-profile.md` is missing, walk through the developer profile interview. This is the same interview from `/project-init` Phase 1, but standalone.

**Questions to ask:**

1. **Name**: What should Claude call you?

2. **Professional background**: What's your current role / occupation?
   - Options: Student, Junior Developer, Mid-level Developer, Senior Developer, Non-developer professional, Career changer, Other

3. **Education**: What's your educational background?
   - Options: Self-taught, Bootcamp, CS degree, Other technical degree, Non-technical degree, Other

4. **Programming experience**: How would you rate your overall programming experience?
   - Options: Beginner (< 1 year), Intermediate (1-3 years), Advanced (3-7 years), Expert (7+ years)

5. **Languages & frameworks**: Which languages/frameworks are you comfortable with?
   - Multi-select from common options

6. **Learning style**: How do you prefer to learn?
   - Options: Hands-on, Conceptual, Mixed, Reference-driven

7. **Specific strengths**: Anything you consider yourself particularly strong at?

8. **Specific gaps**: Anything you know you want to learn or improve?

9. **Working style & accessibility** (OPTIONAL):
   "Is there anything about how you work or learn that would help me be a better mentor? This is completely optional. For example: ADHD, autism, dyslexia, limited available time, preference for short or long sessions, etc."
   - If they skip, don't press
   - If they share, note it for mentoring calibration

### 3. Write the Profile

Generate `.claude/context/developer-profile.md` using the template from `.claude/templates/context/developer-profile.md`, filled in with the user's answers.

### 4. Verify Context

After creating the profile, check that the rest of the project docs are intact:
- `CLAUDE.md` exists
- `.claude/context/learning-progress.md` exists
- `.claude/context/project-specs.md` exists
- `.learning/` exists

If anything else is missing, warn the user but don't try to recreate it -- those files are tracked in git and something is wrong if they're missing after a clone.

### 5. Summary

Report what was recreated and confirm the project is ready to use. Suggest `/lesson-start` to pick up where they left off.

## Important Notes

- **Privacy first** -- `developer-profile.md` is gitignored because it may contain personal information. Never suggest removing it from `.gitignore`.
- **Don't duplicate** -- if the file already exists, skip it and say so.
- **Quick and focused** -- this should take under 2 minutes. It's just recreating one file, not re-running the full project init.
