---
name: tdd
description: Build a feature TDD-style — write Playwright test first, confirm failure, implement, iterate until passing
usage: /tdd <feature description>
examples:
  - /tdd add a login page that redirects to dashboard after successful auth
  - /tdd the contact form submits and shows a success toast
allowed-tools:
  - Bash(npx:*)
  - Bash(git:*)
  - Bash(npm:*)
  - Read
  - Edit
  - Write
  - Glob
  - Grep
  - Agent
  - TaskCreate
  - TaskUpdate
---

# TDD Skill

Build a feature using test-driven development with Playwright. Write the test first, watch it fail, build the feature, then iterate until the test passes.

## Workflow

### 1. Understand the Feature
- Read the user's feature description
- Explore the codebase to understand existing patterns, routes, components, and test structure
- Identify where the new feature fits

### 2. Check Playwright Setup
```bash
npx playwright --version
```
If Playwright is not installed, install it:
```bash
npm install -D @playwright/test && npx playwright install
```
Check for existing Playwright config (`playwright.config.ts` or `.js`) and existing tests to match conventions.

### 3. Write the Test (RED)
- Create a Playwright test file that describes the expected behavior of the feature
- Follow existing test conventions if any exist in the project
- The test should be specific and meaningful — test user-visible behavior, not implementation details
- Keep the test focused on the feature being built

### 4. Run the Test — Confirm Failure
```bash
npx playwright test <test-file> --reporter=list
```
- The test **must fail** at this stage. If it passes, the test is not testing anything new — revise it.
- Read the failure output to confirm it fails for the right reason (missing page/component/route, not a syntax error).

### 5. Build the Feature (GREEN)
- Implement the minimum code to make the test pass
- Follow existing project patterns and conventions
- Don't over-engineer — just make the test pass

### 6. Run the Test — Check for Pass
```bash
npx playwright test <test-file> --reporter=list
```
- **If it passes**: Move to step 7.
- **If it fails**: Read the error, fix the implementation, and run again. Repeat until passing. Do not modify the test to make it pass — fix the code.

### 7. Done
- Report to the user that the feature is implemented and the test passes
- Mention what was built and what the test covers

## Rules

- **Never weaken a test to make it pass.** Fix the implementation, not the test.
- **Exception**: If the test has a genuine bug (wrong selector, typo, unrealistic assertion), fix the test — but note it to the user.
- **Run the full test command**, not just type-checks. The Playwright test must actually execute in a browser.
- **If the dev server needs to be running**, start it in the background before running tests, or use `webServer` config in `playwright.config.ts`.
- **Keep tests isolated** — each test should not depend on state from other tests.
