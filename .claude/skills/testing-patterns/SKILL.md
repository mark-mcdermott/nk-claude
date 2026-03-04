---
name: testing-patterns
description: Testing patterns and standards for projects
usage: /testing-patterns [type]
examples:
  - /testing-patterns unit
  - /testing-patterns integration
  - /testing-patterns e2e
---

# Testing Patterns Skill

Provides testing patterns and quality standards for development projects.

## When to Test

- After implementing new features
- Before commits
- After refactoring
- Before milestone merges
- When fixing bugs (write test that reproduces the bug first)

## Testing Standards

### Pass Criteria
- Zero test failures
- Linting passes
- No regressions in existing tests

### Testing Priorities
1. **Unit tests**: Individual functions and components
2. **Integration tests**: Component interactions and API boundaries
3. **E2E tests**: Critical user flows (if applicable)

## Git Integration
- Include test results context in commit messages
- Test before creating milestones
- Document test failures as learning opportunities

## Type-Specific Patterns

### unit
Focus on testing individual functions, components, and modules in isolation.
- Mock external dependencies
- Test edge cases and error conditions
- Keep tests fast and focused

### integration
Focus on testing interactions between components and services.
- Test API boundaries
- Verify data flow between modules
- Test with realistic (but controlled) data

### e2e
Focus on testing complete user flows through the application.
- Test critical paths (auth, core workflows)
- Verify UI rendering and interactions
- Test across different viewport sizes if applicable

## Test-Driven Development Pattern
1. Write a failing test that describes desired behavior
2. Implement the minimum code to make it pass
3. Refactor while keeping tests green
4. Repeat
