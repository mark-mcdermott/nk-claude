# Commit Style: gitmoji

All commit messages must use a **gitmoji** prefix followed by a brief description.

## Format

```
:emoji: brief description

- Detail about change 1
- Detail about change 2
```

Body is optional — use bullets when the commit touches multiple things.

## Examples

Single change:
```
:bug: resolve login redirect loop on expired sessions
```

With body:
```
:sparkles: add merch store page

- Create product grid with responsive layout
- Add cart sidebar with quantity controls
- Wire up Stripe checkout integration
```

## Common Gitmojis

| Emoji | Code | When |
|-------|------|------|
| :sparkles: | `:sparkles:` | New feature |
| :bug: | `:bug:` | Bug fix |
| :recycle: | `:recycle:` | Refactor |
| :lipstick: | `:lipstick:` | UI/styling changes |
| :zap: | `:zap:` | Performance improvement |
| :white_check_mark: | `:white_check_mark:` | Add/update tests |
| :wrench: | `:wrench:` | Configuration/tooling |
| :memo: | `:memo:` | Documentation |
| :construction_worker: | `:construction_worker:` | CI/CD changes |
| :hammer: | `:hammer:` | Build system changes |
| :fire: | `:fire:` | Remove code/files |
| :truck: | `:truck:` | Move/rename files |
| :tada: | `:tada:` | Initial commit |
| :lock: | `:lock:` | Security fix |
| :arrow_up: | `:arrow_up:` | Upgrade dependency |
| :arrow_down: | `:arrow_down:` | Downgrade dependency |
| :art: | `:art:` | Improve structure/format |

## Rules

- Subject line: `:emoji: description` — lowercase, no period at end.
- Body (optional): blank line after subject, then bullet list.
- No AI attribution. No co-author lines, no signatures, no references to Claude/AI.
