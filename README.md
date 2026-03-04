# Claude Code App Development Kit

A reusable `.claude/` configuration for building apps with [Claude Code](https://claude.ai/claude-code) while learning about app development along the way.

## What This Is

A ready-to-clone project scaffold that gives Claude Code:
- **Hooks** that enforce quality gates (no AI attribution in commits, lint/test reminders)
- **Agents** for delegating complex work (git operations, documentation, debugging)
- **Skills** (slash commands) for common workflows (`/commit`, `/lesson-start`, `/progress-review`, `/project-init`)
- **Rules** for teaching methodology, context preservation, and workflow patterns
- **An output style** that makes Claude act as a senior engineer mentor
- **Templates** for tracking learning progress, curriculum, decisions, and project specs

It's stack-agnostic and topic-agnostic -- designed to be specialized for any project.

## Quick Start

```bash
# 1. Clone this repo
git clone https://github.com/mark-mcdermott/nk-claude.git my-project
cd my-project

# 2. Open Claude Code
claude

# 3. Initialize your project
/project-init
```

The `/project-init` skill will:
- Interview you about your background, skills, learning style, and any accessibility needs
- Interview you about your project (stack, features, hosting, etc.)
- Scaffold `.claude/context/` (Claude's working files), `.learning/` (your learning space), and `CLAUDE.md`
- Create a curriculum calibrated to your skill level and learning goals
- Optionally generate learning guides for topics you're studying

### After a Fresh Clone

Some files (like your developer profile) are gitignored for privacy. If you clone the repo on a new machine:

```
> /fresh-clone
```

This walks you through recreating any missing gitignored files.

## Directory Structure

```
.
├── README.md                        # This file
├── CLAUDE.md                        # Project entry point for Claude (created by /project-init)
├── .claude/
│   ├── settings.json                # Hook configuration
│   ├── README.md                    # .claude/ directory guide
│   ├── hooks/                       # Git and code quality guards
│   │   ├── git-commit-guard.sh      # Blocks AI co-author attribution
│   │   ├── pre-commit-guard.sh      # Lint/test reminder before commits
│   │   └── test-reminder.sh         # Test reminder after code edits
│   ├── agents/                      # Delegatable agent definitions
│   │   ├── README.md                # Agent selection guide
│   │   ├── git-manager.md           # Complex git operations
│   │   ├── documentation.md         # Documentation maintenance
│   │   └── debugger.md              # Systematic debugging
│   ├── output-styles/               # Communication style configs
│   │   ├── README.md                # Style guide
│   │   └── teaching-mentor.md       # Senior engineer mentor style
│   ├── rules/                       # Always-active behavior rules
│   │   ├── learning-workflow.md     # Teaching methodology & session structure
│   │   └── local-overrides.md       # Project-level setting overrides
│   ├── skills/                      # Slash command definitions
│   │   ├── README.md                # Skill index
│   │   ├── commit/                  # /commit - quick git commits + PRs
│   │   ├── docs-audit/              # /docs-audit - documentation health check
│   │   ├── educational-workflow/    # /educational-workflow - session management
│   │   ├── lesson-start/            # /lesson-start - session initialization
│   │   ├── progress-review/         # /progress-review - spaced repetition
│   │   ├── project-init/            # /project-init - scaffold a new project
│   │   ├── fresh-clone/             # /fresh-clone - recreate gitignored files
│   │   └── testing-patterns/        # /testing-patterns - testing reference
│   ├── context/                     # Claude's working context (created by /project-init)
│   │   ├── learning-progress.md     # Current status, next steps, decisions log
│   │   ├── curriculum-outline.md    # Learning curriculum with completion tracking
│   │   ├── developer-profile.md     # Developer background & accessibility (GITIGNORED)
│   │   ├── progress-tracking.md     # Spaced repetition & skill mastery
│   │   ├── learning-phases.md       # Phase definitions & objectives
│   │   ├── project-specs.md         # Tech stack, architecture, setup
│   │   └── reference/               # Technical reference docs (grows with project)
│   └── templates/                   # Templates used by /project-init
│       ├── CLAUDE.md.template       # CLAUDE.md template
│       ├── context/                 # -> copies to .claude/context/
│       └── learning/                # -> copies to .learning/
└── .learning/                       # User's learning space (created by /project-init)
    ├── notes/                       # Your lesson notes
    └── guides/                      # Learning guides (git, topics you're studying)
        └── git-guide.md             # Git workflow reference
```

### What Goes Where

| Location | Who writes it | Who reads it | What's in it |
|----------|--------------|-------------|--------------|
| `.claude/context/` | Claude (auto-maintained) | Claude | Progress, curriculum, specs, tracking |
| `.learning/notes/` | You (during lessons) | You | Your learning notes |
| `.learning/guides/` | Claude (on request) | You | Readable guides on topics you're learning |
| `.claude/agents/` etc. | Part of this repo | Claude | Configuration (don't edit unless customizing) |
| `docs/` | You (if you want) | Anyone | Your app's documentation (not created by default) |

## How It Works

### For Development
Claude acts as a senior engineer mentor. It will:
- **Build and teach simultaneously** -- explains concepts as they come up during real implementation
- Ask probing questions to verify understanding
- **Automatically track your learning progress** -- you never need to manually update the curriculum, remember where you left off, or prompt Claude about what's next. Just show up and say "let's keep going."
- You can steer: "just build it" (skip teaching), "explain that more" (go deeper), or "teach me about X first" (lesson before building)

### For Quality
Hooks automatically:
- Block AI co-author attribution in git commits
- Remind you to run lint/tests before commits
- Suggest running related tests after code edits

### For Organization
Skills provide repeatable workflows:
- `/commit` -- quick commits + PRs with conversation context
- `/lesson-start` -- initialize a learning session
- `/progress-review` -- review previously learned concepts
- `/docs-audit` -- check documentation health
- `/project-init` -- scaffold a new project
- `/fresh-clone` -- recreate gitignored files after cloning

## Example Walkthrough: Building a CRUD App

Here's a concrete example of using this setup to build a React/TypeScript CRUD app deployed to Cloudflare Pages with a Neon (PostgreSQL) database -- starting from zero and learning along the way.

### 1. Clone and Initialize

```bash
git clone https://github.com/mark-mcdermott/nk-claude.git my-crud-app
cd my-crud-app
claude
```

Once Claude opens:

```
> /project-init my-crud-app
```

Claude interviews you. You'd answer something like:

- **Role**: Junior Developer
- **Experience**: Intermediate (1-3 years)
- **Skills**: JavaScript, HTML/CSS, some React
- **Learning style**: Hands-on
- **Growth areas**: TypeScript, databases, deployment
- **Project description**: "A CRUD web app for managing a book collection"
- **Platforms**: Web app
- **Frontend**: React
- **Backend**: Node.js
- **Database**: PostgreSQL (Neon)
- **Hosting**: Cloudflare Pages
- **Learning goals**: Frontend, Backend/API, Database design, Deployment

Claude scaffolds your `CLAUDE.md`, context files, learning space, developer profile, and curriculum -- all filled in with your actual answers. It also asks if you'd like learning guides generated for any of your topics.

### 2. Set Up the Repository

```
> Let's set up the GitHub repo and scaffold the React app
```

Claude creates your repo, scaffolds with Vite + React + TypeScript, installs dependencies, and makes the initial commit. Since `main` is protected, it works on a branch:

```
> /commit
```

Claude commits, pushes, creates a PR, and gives you the URL:

> "Here's the PR: https://github.com/you/my-crud-app/pull/1
> Please review the scaffolded project and merge when you're satisfied."

You review on GitHub, merge, and you're off.

### 3. Start Learning and Building

```
> /lesson-start database-design
```

Claude checks your progress, sees you're in Phase 1, and starts teaching you about database schema design for your book collection app -- but hands-on, not theoretical. It walks you through:

- What tables you need (books, authors, etc.)
- Why normalization matters
- How to set up Neon

It asks you questions along the way to check understanding:

> "If a book can have multiple authors and an author can write multiple books, what kind of relationship is that? How would you model it?"

### 4. Implement Features

As you build each feature, the workflow is:

```
> Let's implement the books API endpoint
```

Claude creates a feature branch (`feat/books-api`), walks you through the implementation, explains concepts as you go, and commits frequently:

```
> /commit
```

When the feature is done:

```
> /commit
```

Claude creates a PR with a summary of changes and a review checklist:

> "PR created: https://github.com/you/my-crud-app/pull/3
>
> This adds the books CRUD API with input validation. Before merging, check:
> - The SQL queries in `src/api/books.ts`
> - Error handling for invalid input
> - That the Neon connection string isn't hardcoded"

### 5. Review Your Learning

After a few sessions:

```
> /progress-review
```

Claude checks what you've learned and quizzes you with spaced repetition:

> "Last week we covered database normalization. Quick check -- why did we create a separate `authors` table instead of storing author names directly in the `books` table?"

### 6. Continue Building

The typical session loop looks like this:

```
> /lesson-start                    # Start session, check progress
> Let's add user authentication    # Build the next feature
> /commit                          # Commit + PR when feature is done
> /progress-review                 # Optional: review past concepts
```

### 7. Deploy

When you're ready to deploy:

```
> Let's set up Cloudflare Pages deployment
```

Claude teaches you about CI/CD, walks you through connecting your GitHub repo to Cloudflare Pages, setting environment variables for your Neon connection string, and getting your app live.

### What You End Up With

After a few weeks of this workflow:

- A **working CRUD app** deployed at your-app.pages.dev
- A **GitHub repo** with clean PR history showing your progression
- **Learning guides** in `.learning/guides/` you can reference anytime
- **Actual understanding** of React, TypeScript, PostgreSQL, and deployment -- not just copy-pasted code

## Privacy

`.claude/context/developer-profile.md` is **gitignored** because it may contain personal information (accessibility needs, neurodivergence, learning challenges, etc.). This means:

- It won't be pushed to your repo, even if the repo is public
- After a fresh `git clone`, you'll need to run `/fresh-clone` to recreate it
- The tradeoff is worth it -- your personal info stays local to your machine

Everything else is tracked in git and will survive a clone.

## Customizing

### Adding a Tech Stack
`/project-init` handles this during the interview. If you need to update later:
- `CLAUDE.md` -- update stack details
- `.claude/context/project-specs.md` -- update architecture and setup
- `.claude/hooks/pre-commit-guard.sh` -- add your lint/test commands

### Adding Agents
Create `.claude/agents/your-agent.md` and register it in:
- `.claude/agents/README.md`
- `CLAUDE.md`

### Adding Skills
Create `.claude/skills/your-skill/SKILL.md` and register it in:
- `.claude/skills/README.md`
- `CLAUDE.md`

## License

MIT
