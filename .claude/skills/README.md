# Skills Index

## Available Skills

| Skill | Command | Alias | When to Use |
|-------|---------|-------|-------------|
| Branch | `/branch` | | Create a new branch and switch to it |
| Branch & Feature | `/branch-and-feature` | `/baf` | Create a branch and start building a feature |
| Commit | `/commit` | | Quick git commits with conversation context |
| Commit & PR | `/commit-and-pr` | `/cpr` | Commit, push, and create a PR in one step |
| Commit Push on Main | `/commit-push-on-main` | `/cpom` | Commit, merge to main if needed, and push |
| Abort | `/abort` | | Abandon the current branch and return to main |
| Merged | `/merged` | | Clean up after merging a PR |
| Permissions | `/permissions` | | Toggle between loose and tight permission presets |
| Stack | `/stack` | | Configure CLAUDE.md and hooks for a tech stack |

## Skill Descriptions

### /commit
**Usage**: `/commit [type]`
**Examples**: `/commit`, `/commit checkpoint`, `/commit experiment`
**Does**: Checks status, stages and commits with gitmoji message. For complex git operations (conflicts, rebase), delegate to git-manager agent instead.

### /commit-and-pr
**Alias**: `/cpr`
**Usage**: `/cpr` or `/commit-and-pr`
**Does**: Runs pre-commit checks, stages, commits with gitmoji message, pushes, and creates a PR. Returns the PR URL for review.

### /commit-push-on-main
**Alias**: `/cpom`
**Usage**: `/cpom` or `/commit-push-on-main`
**Does**: Commits current changes with gitmoji message. If on main, pushes directly. If on a feature branch, switches to main, merges the branch, and pushes.

### /branch
**Usage**: `/branch <branch-name>`
**Examples**: `/branch feat/dark-mode`, `/branch fix/broken-publish`
**Does**: Checks for clean state, creates the branch, switches to it. No commits, no implementation.

### /branch-and-feature
**Alias**: `/baf`
**Usage**: `/baf <branch-name> <feature description>`
**Examples**: `/baf merch-store add a merch store page`, `/baf fix/broken-publish fix the publish flow`
**Does**: Creates a branch (auto-prefixes `feat/` if no prefix given), then starts implementing the described feature.

### /abort
**Usage**: `/abort`
**Does**: Stashes any uncommitted work, switches to main, and force-deletes the branch. Safe bail-out when you want to discard a branch entirely.

### /merged
**Usage**: `/merged`
**Does**: Checks out main, pulls latest, deletes the merged branch locally and on the remote.

### /permissions
**Usage**: `/permissions <mode>`
**Modes**: `loose` (permissive, most things auto-allowed) or `tight` (read-only auto-allowed, everything else prompts)
**Does**: Rewrites the permissions block in `settings.local.json` to the selected preset. Preserves other settings. Destructive commands (`rm -rf`, `sudo`, force push) are always denied in loose mode.

### /stack
**Usage**: `/stack <mode>`
**Modes**: `zendcats` (Zod, Edge/Neon/Vercel, Next.js, Drizzle, Capacitor, Auth, Tauri, shadcn-ui) or `open` (any stack)
**Does**: Writes `CLAUDE.md` with stack-specific conventions, updates `pre-commit-guard.sh` with real eslint/prettier checks (zendcats) or generic reminders (open), and narrows `test-reminder.sh` extensions to match.

## Proactive Skill Usage

- Before committing -> `/commit`
- Work is done and needs a PR -> `/cpr`
- Quick commit and push to main -> `/cpom`
- Starting a new feature -> `/baf`
- Abandoning a branch -> `/abort`
- After a PR is merged -> `/merged`
