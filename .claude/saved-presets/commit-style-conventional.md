# Commit Style: conventional

All commit messages must follow **Conventional Commits** style.

## Format

```
type(scope): brief description

- Detail about change 1
- Detail about change 2
```

Scope is optional. Body is optional — use bullets when the commit touches multiple things.

## Examples

Single change:
```
fix: resolve login redirect loop on expired sessions
```

With scope:
```
feat(store): add merch store page with product grid
```

With body:
```
feat(store): add merch store page

- Create product grid with responsive layout
- Add cart sidebar with quantity controls
- Wire up Stripe checkout integration
```

## Types

| Type | When |
|------|------|
| feat | Adding new functionality |
| fix | Fixing broken behavior |
| refactor | Restructuring without behavior change |
| style | Visual/styling/formatting changes |
| perf | Performance improvements |
| test | Adding or updating tests |
| chore | Configuration, tooling, dependencies |
| docs | Documentation updates |
| ci | CI/CD pipeline changes |
| build | Build system changes |

## Rules

- Subject line: `type(scope): description` — lowercase, no period at end.
- Body (optional): blank line after subject, then bullet list.
- No AI attribution. No co-author lines, no signatures, no references to Claude/AI.
