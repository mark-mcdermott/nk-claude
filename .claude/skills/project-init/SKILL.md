---
name: project-init
description: Scaffold docs and CLAUDE.md for a new project via interactive interview
usage: /project-init [project-name]
examples:
  - /project-init
  - /project-init hoobie
  - /project-init my-app
allowed-tools:
  - Read
  - Write
  - Edit
  - Glob
  - Bash(cp:*)
  - Bash(mkdir:*)
  - Bash(ls:*)
  - AskUserQuestion
---

# Project Init Skill

Scaffolds `.claude/context/`, `.learning/`, and `CLAUDE.md` for a new project using templates from `.claude/templates/`. Conducts an interactive interview to gather project details and developer profile so all files are filled in -- not left as placeholders.

## Workflow

### Phase 1: Developer Profile Interview

Ask the user about themselves so the teaching/learning system can calibrate appropriately. Use AskUserQuestion for structured choices and follow up conversationally for details.

**Questions to ask:**

1. **Name**: What should Claude call you?

2. **Professional background**: What's your current role / occupation?
   - Options: Student, Junior Developer, Mid-level Developer, Senior Developer, Non-developer professional, Career changer, Other

3. **Education**: What's your educational background?
   - Options: Self-taught, Bootcamp, CS degree, Other technical degree, Non-technical degree, Other
   - Follow up: Any specific coursework or training relevant to this project?

4. **Programming experience**: How would you rate your overall programming experience?
   - Options: Beginner (< 1 year), Intermediate (1-3 years), Advanced (3-7 years), Expert (7+ years)

5. **Languages & frameworks**: Which languages/frameworks are you comfortable with?
   - Multi-select from common options: JavaScript/TypeScript, Python, Ruby, Go, Rust, Java/Kotlin, Swift, C#, SQL, HTML/CSS, React, Vue, Svelte, Angular, Node.js, Other
   - For each selected, ask confidence level if relevant

6. **Learning style**: How do you prefer to learn?
   - Options: Hands-on (build first, explain later), Conceptual (understand theory, then build), Mixed (brief explanation, then hands-on), Reference-driven (show me docs and examples)

7. **Specific strengths**: Anything you consider yourself particularly strong at? (free text)

8. **Specific gaps**: Anything you know you want to learn or improve? (free text)

9. **Working style & accessibility** (OPTIONAL -- frame carefully):
   Ask: "Is there anything about how you work or learn that would help me be a better mentor? This is completely optional. For example: ADHD, autism, dyslexia, limited available time, preference for short or long sessions, tendency to get overwhelmed by too many options, anxiety about breaking things, etc. This helps me calibrate pacing, session structure, and communication style."
   - This is free text, not multiple choice -- let them share what feels right
   - If they skip it, that's totally fine -- don't press
   - If they share something, use it to genuinely adjust the mentoring approach:
     - **ADHD**: Shorter sessions, more frequent checkpoints, reduce tangents, clear next-step at all times, celebrate small wins
     - **Autism**: Be precise and literal, avoid ambiguous instructions, provide structure and predictability, explain social conventions in code review explicitly
     - **Dyslexia**: Favor code examples over long text explanations, use clear variable naming
     - **Anxiety**: Emphasize that mistakes are safe (git keeps everything), be extra reassuring about experimentation
     - **Limited time**: Front-load the most valuable learning, skip nice-to-haves, respect session boundaries

Save the developer profile to `.claude/context/developer-profile.md`. **This file is gitignored for privacy** -- it contains personal information that shouldn't be in a public repo. See `/fresh-clone` for recreating it after a fresh clone.

### Phase 2: Project Interview

Ask the user about the project so CLAUDE.md and project-specs can be filled in properly.

**Questions to ask:**

1. **Project name** (if not provided as argument)

2. **Project description**: What does this app do? (1-3 sentences)

3. **Target platforms**: Where will this run?
   - Multi-select: Web app, iOS, Android, Desktop (Mac), Desktop (Windows), CLI, Other

4. **Key features**: What are the main features? (free text -- list them out)

5. **Tech stack approach**: Do you have a specific tech stack in mind, or should we figure it out together based on your project's requirements?
   - Options: I have a stack in mind, I have some preferences but am flexible, Let's figure it out together
   - **If "I have a stack in mind"**: Ask questions 6-10 below to capture their choices
   - **If "some preferences but flexible"**: Ask which parts they have opinions on, skip the rest. For anything they're unsure about, note it as "TBD -- will decide during development" in project-specs.md
   - **If "figure it out together"**: Skip questions 6-10 entirely. Record all tech choices as "TBD -- will decide during development" in project-specs.md. Claude will help them evaluate options when it's time to make each decision during actual development. Add a note to the curriculum/learning-progress that early sessions should include tech stack exploration.

6. **Frontend preferences** (only if answering tech questions):
   - App type: SPA, SSR/SSG, Full-stack monolith, API + separate frontend, Mobile-first, Other
   - Framework: React, Vue, Svelte, SvelteKit, Next.js, Nuxt, Astro, No preference, Other
   - UI/styling: Tailwind CSS, ShadcnUI, Material UI, No preference, Other

7. **Backend preferences** (only if answering tech questions):
   - Options: Node.js, Bun, Deno, Python, Ruby/Rails, Go, No preference, Other

8. **Database preferences** (only if answering tech questions):
   - Options: PostgreSQL, SQLite, MySQL, MongoDB, No preference, Other
   - Follow up if applicable: Hosted preference? (Neon, PlanetScale, Supabase, self-hosted, etc.)

9. **Hosting preferences** (only if answering tech questions):
   - Options: Cloudflare Pages/Workers, Vercel, Netlify, Railway, AWS, No preference, Other

10. **Auth requirements** (only if answering tech questions):
    - Options: Yes (email/password), Yes (OAuth/social), Yes (both), No, Not sure yet

11. **Third-party integrations**: Any specific APIs or services you need to integrate? (free text, optional)

12. **Project pace**: What's your timeline for this project?
    - Options: Ship it fast (weekend/hackathon), Steady build (weeks/months), Long-term learning project, Not sure yet
    - This affects how much learning infrastructure gets set up:
      - **Ship it fast**: Minimize teaching, skip curriculum/progress tracking, focus on building. Still create CLAUDE.md and project-specs for context, but skip learning-phases, curriculum-outline, and progress-tracking. Suggest autonomy optimizations (see Phase 3i).
      - **Steady build**: Full setup with lighter teaching -- Claude teaches when gaps appear but doesn't structure formal lessons unless asked.
      - **Long-term learning**: Full setup as designed -- curriculum, progress tracking, spaced repetition, the works.
      - **Not sure**: Default to steady build, which scales in either direction.

13. **Learning goals** (skip if "ship it fast"):
    What do you most want to learn by building this?
    - Multi-select: Frontend development, Backend/API development, Database design, Authentication, Deployment/DevOps, Testing, Mobile development, Real-time features, Payment integration, Other

### Phase 3: Scaffold Files

#### 3a. Copy Context Templates to .claude/context/
Copy Claude's working context files from `.claude/templates/context/`.

**For steady build / long-term learning pace** (full set):
```
.claude/templates/context/learning-progress.md    -> .claude/context/learning-progress.md
.claude/templates/context/curriculum-outline.md   -> .claude/context/curriculum-outline.md
.claude/templates/context/progress-tracking.md    -> .claude/context/progress-tracking.md
.claude/templates/context/learning-phases.md      -> .claude/context/learning-phases.md
.claude/templates/context/project-specs.md        -> .claude/context/project-specs.md
.claude/templates/context/reference/              -> .claude/context/reference/
```

**For ship-it-fast pace** (minimal set):
```
.claude/templates/context/learning-progress.md    -> .claude/context/learning-progress.md
.claude/templates/context/project-specs.md        -> .claude/context/project-specs.md
```
Skip curriculum-outline, progress-tracking, and learning-phases — they add overhead without value for a weekend project. The learning-progress file still serves as a general status/decisions tracker even without the learning infrastructure.

#### 3b. Copy Learning Templates to .learning/
Copy user-facing learning files from `.claude/templates/learning/`:

```
.claude/templates/learning/guides/git-guide.md    -> .learning/guides/git-guide.md
```

Also create:
```bash
mkdir -p .learning/notes
```

#### 3c. Generate CLAUDE.md
Copy `.claude/templates/CLAUDE.md.template` to `./CLAUDE.md` and fill in ALL fields using interview answers:
- `[PROJECT_NAME]` -> actual project name
- `[Brief project description]` -> user's description
- Stack & Patterns section -> filled with actual tech choices
- Add any project-specific agents or consultants if the stack warrants them

#### 3d. Generate developer-profile.md (GITIGNORED)
Create `.claude/context/developer-profile.md` with the developer's background info.

**This file is gitignored for privacy.** It may contain personal information (accessibility needs, neurodivergence, etc.) that shouldn't be in a public repo. The `/fresh-clone` skill recreates it after a fresh clone.

```markdown
# Developer Profile

## About
- **Name**: [name]
- **Role**: [role]
- **Education**: [education]
- **Experience Level**: [level]

## Technical Skills
| Skill | Confidence |
|-------|------------|
| [language/framework] | [beginner/intermediate/advanced/expert] |

## Learning Style
[their preference]

## Strengths
[their self-assessed strengths]

## Growth Areas
[what they want to learn]

## Learning Goals for This Project
[selected goals]

## Working Style & Accessibility
[optional -- anything they shared about how they work/learn best]
```

#### 3e. Ensure .gitignore includes developer-profile.md
Add the following to `.gitignore` (create if it doesn't exist):
```
# Private developer profile (contains personal info)
.claude/context/developer-profile.md
```

#### 3f. Fill In Context Files
Using interview answers, fill in real content (not placeholders) in:

- **`.claude/context/learning-progress.md`** -> set project name, mission, initial phase, relevant skills status. If tech stack was chosen, add decisions log entries with rationale. If TBD, add a note that tech stack decisions will be made during development.
- **`.claude/context/project-specs.md`** -> fill in known tech stack sections. For any TBD choices, use "TBD -- will evaluate and decide during development" rather than leaving placeholders. Include what IS known (platforms, features, integrations).
- **`.claude/context/learning-phases.md`** -> create real phases based on the project's features and the developer's skill gaps. If tech stack is TBD, include an early phase for "Tech Stack Exploration" where Claude helps evaluate options.
- **`.claude/context/curriculum-outline.md`** -> create initial curriculum sections based on what they need to learn to build the project. If tech stack is TBD, include stack evaluation as an early curriculum item.
- **`.claude/context/progress-tracking.md`** -> set up skill areas and proficiency targets based on their current level and goals

#### 3g. Ask About Learning Guides
Ask the user: "Would you like me to generate learning guides for any of the topics in your curriculum? For example, I can create guides for [list 2-3 topics from their learning goals]. These go in `.learning/guides/` for your reference."

If yes, generate guides for the requested topics. Each guide should be a practical, readable reference the user can consult independently -- not Claude's internal context.

#### 3h. Stack Customization (only if tech stack is known)

**Skip this step if the stack is TBD.** When the stack is decided later during development, Claude will auto-run this step then (see `learning-workflow.md` "Stack Finalization" rule).

Once the tech stack is known, customize the `.claude/` configuration for that stack:

**1. Update `pre-commit-guard.sh` with real commands:**
Replace the generic checklist with actual lint/test commands. Examples:
- React/Next.js: `npm run lint`, `npm test`
- Vue/Nuxt: `npm run lint`, `npm run test:unit`
- Rails: `bundle exec rubocop`, `bundle exec rspec`
- Python/Django: `ruff check .`, `pytest`
- Go: `go vet ./...`, `go test ./...`

**2. Narrow `test-reminder.sh` extensions:**
Remove source file extensions the project won't use. If it's a React/TypeScript project, keep `.ts`, `.tsx`, `.js`, `.jsx` and remove `.vue`, `.svelte`, `.rb`, `.py`, `.go`, `.rs`, `.java`, `.kt`, `.swift` (and vice versa for other stacks).

**3. Generate stack-specific testing skill (recommended):**
Create `.claude/skills/testing-patterns/SKILL.md` — **overwrite** the generic one with stack-specific patterns. Include:
- Actual test runner setup and commands (Vitest, Jest, Pytest, RSpec, etc.)
- Framework-specific testing patterns (e.g., React Testing Library component tests, Rails model/controller specs, Django TestCase patterns)
- Mocking/stubbing patterns for the specific stack
- Common testing pitfalls for that framework
- Example test structures using the project's actual file naming conventions

**4. Generate stack expert agent (only for opinionated stacks):**
Only create this when the stack has enough conventions/idioms to genuinely change Claude's output quality. Create `.claude/agents/stack-expert.md`.

| Stack | Create agent? | Why |
|-------|---------------|-----|
| Rails | Yes | Strong conventions (service objects, concerns, ActiveRecord patterns, Rails Way) |
| Django | Yes | ORM patterns, class-based views, middleware conventions |
| Angular | Yes | Dependency injection, RxJS patterns, module structure |
| Next.js | Maybe | App Router vs Pages Router patterns, RSC conventions — create if using App Router |
| SvelteKit | Maybe | Load functions, form actions, specific patterns — create if student is new to it |
| React (plain) | No | Not opinionated enough to warrant dedicated agent |
| Vue (plain) | No | Composition API is straightforward, covered in general teaching |
| Express/Fastify | No | Too thin to need dedicated guidance |
| Go | No | Language is simple by design, stdlib-centric |

The expert agent should contain:
- Framework idioms and conventions (the "right way" to do things)
- Common anti-patterns and why they're problematic
- File/folder structure conventions
- Naming conventions specific to the framework
- Key decisions the framework has opinions about

**5. Update CLAUDE.md:**
Add references to any new agents/skills created. If a stack expert agent was generated, add it to the agents section.

**6. Register new components:**
- If a stack expert agent was created, add it to `.claude/agents/README.md`
- The testing skill overwrites the existing one, so no registration change needed

**7. MCP server recommendations:**
Check what MCP servers are already configured (read the MCP config in `.claude/settings.json` or `~/.claude/settings.json`), then recommend **only** servers that would genuinely add capability Claude doesn't already have via built-in tools. Limit to 1-3 targeted suggestions with a brief reason for each.

**Servers that add real capability (recommend based on stack):**

| Stack component | MCP server | Why it helps |
|----------------|------------|-------------|
| PostgreSQL | Postgres MCP | Direct SQL queries without connection string wrangling |
| Supabase | Supabase MCP | Manage auth, storage, and DB directly |
| Neon | Neon MCP | Branch databases, manage schemas directly |
| Any with Sentry | Sentry MCP | Pull real error data from production |
| Design-heavy apps | Figma MCP | Reference design files during implementation |
| Apps needing browser testing | Puppeteer/Playwright MCP | Interact with the running app |

**Don't recommend (redundant with built-in tools):**
- GitHub MCP → `gh` CLI already works
- File system MCP → Read/Write/Glob/Grep are built-in
- Fetch/HTTP MCP → WebFetch is built-in
- Search MCP → WebSearch is built-in

**Context window tradeoff**: MCP servers consume context. Each server's tool definitions are loaded into the context window at the start of every conversation, and each tool call/response takes additional space. A typical MCP server with 5-10 tools costs roughly 1,000-3,000 tokens of always-loaded context per server. This is similar to what the entire `.claude/rules/` directory costs (~4,100 tokens). Adding 3-4 MCP servers could cost 5,000-12,000 tokens — meaningful but manageable on a 200k window.

**How to present**: When recommending MCP servers, be transparent about the tradeoff:
- "Based on your stack, these MCP servers would give me capabilities I don't have out of the box: [list]."
- "Each MCP server takes up some of our conversation context (~1,000-3,000 tokens per server for tool definitions). With [N] servers, that's roughly [estimate] tokens — about [X]% of our context window. This is a minor tradeoff for the capability they add, but worth knowing about."
- "Want me to help set any of them up?"

If none are relevant, skip this step entirely — don't recommend MCP servers just for the sake of it.

#### 3i. Autonomy & Workflow Recommendations

Based on the project's scope, pace, and stack, advise the user on workflow optimizations. This is conversational — present options and let them decide.

**1. Permission configuration:**
Help set up `permissions.allow` in `.claude/settings.json` (or `.claude/settings.local.json` for personal prefs) with stack-specific commands that are safe to auto-approve:

```json
{
  "permissions": {
    "allow": [
      "Bash(npm run lint)",
      "Bash(npm run test *)",
      "Bash(npm run build)",
      "Bash(git status)",
      "Bash(git diff *)",
      "Bash(git log *)"
    ]
  }
}
```

Adapt for the stack (e.g., `Bash(bundle exec *)` for Rails, `Bash(pytest *)` for Python). Explain:
- These are non-destructive commands safe to auto-approve
- Dangerous commands (`git push`, `rm`, `npm publish`) are intentionally left out so Claude still asks
- This significantly reduces permission fatigue without sacrificing safety
- For near-full autonomy in a safe environment, mention `--dangerously-skip-permissions` inside a devcontainer (never on bare metal with internet access)

**2. Verification strategy:**
Recommend how Claude should verify its own work before reporting done, based on the stack:

| Approach | When to recommend | Context cost |
|----------|-------------------|--------------|
| `npm run build` + `npm test` | Always (if applicable) | None (Bash) |
| `claude --chrome` (native) | Frontend verification, design checks | None (built-in) |
| Playwright MCP | CI/CD, cross-browser testing | ~2,000-3,000 tokens |
| curl/httpie for API endpoints | Backend API projects | None (Bash) |

**Recommend `claude --chrome` over Playwright MCP for most dev workflows.** It's built-in (no MCP context cost), uses the user's actual browser session, and handles live debugging, design verification, and form testing. Playwright MCP is better for CI/CD and cross-browser testing. Mention that Playwright MCP can be flaky — connection errors are common — and that the native Chrome integration avoids that entirely.

**3. Parallel development** (mention if project scope warrants it):
For larger projects or fast timelines, the user can run multiple Claude instances in parallel:

- **Built-in**: `claude --worktree feature-auth` in one terminal, `claude --worktree feature-api` in another. Each gets an isolated copy of the repo. Mention that each worktree needs its own `npm install` / dependency setup.
- **GitButler**: Alternative that avoids worktree bootstrapping overhead — uses hooks to route each session's work to a separate branch without duplicating the repo. Better for projects with heavy dependencies.
- **Gastown**: For ambitious projects, Steve Yegge's multi-agent orchestrator coordinates 20-30+ Claude instances with persistent task state backed by git. Heavy setup (requires Go, Dolt, tmux) but powerful for large-scale parallel development.

Only mention parallel development if the project is large enough to benefit. A weekend CRUD app doesn't need 5 parallel agents — that's more overhead than it saves.

**4. Pace-specific recommendations:**

- **Ship it fast**: Suggest generous `permissions.allow`, `claude --chrome` for quick visual checks, and possibly parallel worktrees to split frontend/backend work. Skip formal testing until v1 is shipped, then backfill.
- **Steady build**: Standard setup with permissions for common dev commands. Recommend test-driven workflow.
- **Long-term learning**: Full setup. Verification is part of the learning ("here's how we know this works and why testing matters").

**How to present**: "Here are some workflow optimizations based on your project. These are all optional — pick what sounds useful:"

### Phase 4: Summary

Report what was created with a brief overview:
- Developer profile summary
- Tech stack decisions made (or note that stack will be explored together)
- Stack customizations applied (updated hooks, testing skill, expert agent if created)
- MCP servers recommended (if any)
- Autonomy/workflow recommendations discussed
- Learning phases identified (if applicable for pace)
- Guides generated (if any)
- Suggested first steps
- Remind about `/lesson-start` to begin (or "let's start building" for fast-pace projects)

## Important Notes

- **Don't overwrite** existing files -- if a file already exists, skip it and warn
- **Templates stay** -- don't delete `.claude/templates/`, they're the reusable source
- **Fill in real content** -- the whole point of the interview is to avoid placeholder-heavy files. Every `[PLACEHOLDER]` should be replaced with real info from the interview.
- **Be opinionated when asked** -- if the user says "no preference / help me decide", make a recommendation based on their experience level, project needs, and current ecosystem. Explain why briefly.
- **Calibrate teaching level** -- use the developer profile to set appropriate depth in the curriculum. A senior dev learning a new framework needs different pacing than a beginner learning programming.
- **Respect the pace** -- a "ship it fast" project shouldn't get a 12-phase curriculum. Match the infrastructure to the timeline.
- **No docs/ folder** -- don't create a `docs/` directory. That's reserved for the user's own app documentation if they want it later.
