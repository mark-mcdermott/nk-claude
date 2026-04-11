# Claude Skills Starter

A starter kit for Claude Code workflows — skills, hooks, output styles, and config.

## Code Quality Standards

- **Clean code**: readable, well-structured, obvious intent
- **No utility reinvention**: scan the project for existing utils, helpers, hooks, and components before writing anything. Use what exists. Check dependencies too.
- **DRY**: no duplicated logic. Extract shared patterns only when used more than once.
- **Self-documenting**: names tell the story. No comments unless logic is genuinely non-obvious, and then absolute minimum.
- **Architect's eye**: clear boundaries, appropriate (not premature) abstractions, sensible file organization.
- **Security-first**: validate inputs, sanitize outputs, no XSS vectors, no injection, no secrets in code, proper auth checks.
- **Senior craft**: handle edge cases, strict TypeScript (no `any`), no swallowed errors, no leftover TODOs.

## UI Quality Standards

All UI must look like it was designed by a professional designer — not an engineer's afterthought. Dribbble-level quality:
- Visual hierarchy, spacing rhythm, consistent border radii, subtle shadows
- WCAG AA contrast, purposeful color use
- Hover/focus/loading/empty/error states
- Cohesive with the existing design system
- Dark/light theme support when the project has a theme toggle
- Mobile-first responsive design

## No AI Attribution

Zero references to Claude/AI anywhere — not in commits, PRs, co-author lines, code comments, or any project artifact. Commit as the developer.

## Defaults

- **Commit style**: Conventional commits — `type(scope): description`, lowercase, no period
- **Permissions**: Loose — full Read/Edit/Write/Bash/Agent/Skill, with deny rules for `rm -rf`, `sudo`, `force push`, `reset --hard`
- **Output style**: None (standard Claude output). Set `"outputStyle"` in `settings.local.json` to a path like `.claude/output-styles/grug-speak.md` to change it.

Alternative presets are in `.claude/saved-presets/` (gitmoji commits, tight permissions). Two caveman-style output options are in `.claude/output-styles/`.


## Cleanroom Component Library

Most projects use Cleanroom — a shared component/block/module library built on shadcn-ui.

- **Location**: `~/Dev/cleanroom-proj/cleanroom` — also [github.com/mark-mcdermott/cleanroom](https://github.com/mark-mcdermott/cleanroom) and [cleanroom.website](https://cleanroom.website)
- Before building new UI components, check Cleanroom for an existing match
- If a Cleanroom component exists, use it (adapt CSS/Tailwind classes for the project's skin)
- After implementation, note new components or skin elements to contribute back
- Each project has its own "skin" — nearly all differences are CSS/Tailwind classes, occasionally different HTML markup

## Stack: ZENCATS

Most projects use the ZENCATS stack:
- **Z**od — validation, schemas, form validation, API I/O
- **E**dge — Neon (serverless Postgres) + Vercel deployment
- **N**ext.js — App Router, TypeScript strict
- **C**apacitor — mobile builds
- **A**uth — hand-rolled (no third-party auth libraries)
- **T**auri — desktop builds
- **S**hadcn-ui + Tailwind CSS
- (and Drizzle — ORM, schemas in `src/db/schema/`, migrations via `drizzle-kit`)

Common integrations: UploadThing (file/avatar storage), Stripe (pay-tier), Stripe+Printful (merch store). Most projects have a dark/light theme toggle and user dropdown with Account settings.

## Projects

| Project | Description | Local | GitHub | Live |
|---------|-------------|-------|--------|------|
| cleanroom | Component library & app scaffolding CLI | `~/Dev/cleanroom-proj/cleanroom` | [repo](https://github.com/mark-mcdermott/cleanroom) | [cleanroom.website](https://cleanroom.website) |
| diamondheart | Habit tracker — "whole life", health & meditation (75%) | `~/Dev/diamondheart-proj/diamondheart` | [repo](https://github.com/mark-mcdermott/diamondheart) | [diamondheart.app](https://diamondheart.app) |
| frunk | Car docs storage app (80%) | `~/Dev/frunk-proj/frunk` | [repo](https://github.com/mark-mcdermott/frunk) | [frunk.cloud](https://frunk.cloud) |
| hoobie | Kanban app for personal goals (80%) | `~/Dev/hoobie-proj/hoobie` | [repo](https://github.com/mark-mcdermott/hoobie) | [hoobie.app](https://hoobie.app) |
| markmcdermott.io | Dev portfolio site | `~/Dev/markmcdermott.io-proj/markmcdermott.io` | [repo](https://github.com/mark-mcdermott/markmcdermott.io) | [markmcdermott.io](https://markmcdermott.io) |
| mm-claude-starter | Claude starter skills & CLAUDE.md | `~/Dev/mm-claude-starter` | [repo](https://github.com/mark-mcdermott/mm-claude-starter) | — |
| sidvid | AI video app (25%) | `~/Dev/sidvid-proj/sidvid` | [repo](https://github.com/mark-mcdermott/sidvid) | [sidvid.ai](https://sidvid.ai) |
| theme-forseen | NPM package — sidebar color/font scheme picker for dev (90%) | `~/Dev/theme-forseen-proj/theme-forseen` | [repo](https://github.com/mark-mcdermott/theme-forseen) | [npm](https://www.npmjs.com/package/theme-forseen) |
| themeforseen.com | Website for theme-forseen | `~/Dev/themeforseen.com-proj/themeforseen.com` | [repo](https://github.com/mark-mcdermott/themeforseen.com) | [themeforseen.com](https://themeforseen.com) |
| xin | Note-taking & blog publishing app, desktop only (80%) | `~/Dev/xin-proj/xin` | [repo](https://github.com/mark-mcdermott/xin) | [xin.pink](https://xin.pink) |
| floating.is | Fun visualizer of people on a floating island (25%) | `~/Dev/floating.is-proj/floating.is` | [repo](https://github.com/mark-mcdermott/floating.is) | [floating.is](https://floating.is) |
| non-dinos | Presentation on cool prehistoric non-dinosaur animals (90%) | `~/Dev/non-dinos-proj/non-dinos` | [repo](https://github.com/mark-mcdermott/non-dinos) | [nondinos.com](https://nondinos.com) |

## Available Skills

Run `/skills` to list all installed skills. Key ones:

- `/b <branch> <feature>` — full lifecycle: branch, design, TDD, review, QA, PR, merge, cleanup
- `/w <branch> <feature>` — same as `/b` but in an isolated worktree
- `/wd <branch> <feature>` — same as `/w` but with a database copy
- `/cpr` — commit, push, create PR
- `/a` — abandon branch (stash, switch to main, delete branch)
- `/c` — cleanup (stash, delete unused branches and worktrees)
