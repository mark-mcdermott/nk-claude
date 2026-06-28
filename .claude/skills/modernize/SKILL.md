---
name: modernize
description: /modernize — coaching conversation to drag my Claude Code workflow from "six months ago" to current (orchestration, background agents, memory, external actions, verify-loops)
usage: /modernize
examples:
  - /modernize
  - /modernize what should I experiment with today
allowed-tools:
  - Read
  - Glob
  - Grep
  - Bash(git:*)
  - Bash(ls:*)
  - WebFetch
---

# Modernize Skill

A **conversation**, not an autonomous task. The user (a solo dev shipping ~6 small apps) knows their workflow is dated and wants to get current without chasing hype. This skill is a recurring coach: read where they are, remind them what's changed, pick ONE thing to try, encourage. Hand-holding is the point — go slow, be concrete, don't dump a megaplan.

**Never run a big multi-step build here.** This skill only *talks, reads, and recommends*. If the user decides to build something, point them at the relevant built-in or skill and let them invoke it.

## How to run it

### 1. Ground the conversation in their current setup

Quickly read the lay of the land before giving advice:
- `Glob` `~/.claude/skills/*/SKILL.md`, read frontmatter — what skills exist today.
- Note which are still single-dev/single-repo/local git-lifecycle automation (the `/branch` family) vs anything orchestration/background/external.
- If relevant, glance at recent git activity or the projects list to anchor examples in their real work.

Keep this light — a few reads, not an audit.

### 2. The honest read (the framing)

Their skill set is **single-dev, single-repo, local git-lifecycle automation** (branch → TDD → review → QA → PR → merge → cleanup) plus a peon-ping novelty. Still genuinely useful — *don't tell them to throw it out.* But it predates the shift. The five things that define "current," ranked by usefulness **for a solo dev shipping 6 apps**, not by hype:

1. **Orchestration / fan-out** — one assistant → many agents in parallel: fan out finders/reviewers, verify adversarially, synthesize. Primitives they now have: the **Workflow** tool, **Agent** subagents, **`/code-review ultra`** (cloud multi-agent). None of their current skills use any of it.
2. **Background / scheduled agents** — **`/loop`**, **`/schedule`** (cron cloud agents), background Bash tasks. Progress while away: babysit CI, watch a deploy, triage. They have the primitives; nothing uses them.
3. **Memory / self-improvement** — the persistent memory dir didn't exist when these skills were written. "Current" = capturing preferences/feedback as you go instead of re-typing them and re-editing CLAUDE.md.
4. **External actions** — Gmail / GCal / Drive / Vercel MCP are connected (may need auth). The useful version is **not** "buy stocks / make coffee" — it's deploy-status pings, "email me the resume PDF when the build's green," PR-needs-you notifications, calendar-aware scheduling.
5. **Verify-by-running loops** — Plan mode + **`/verify`** (run the app, observe). Agents that check their own work by executing it, not just writing it.

**The trap:** chasing coffee/stocks demos. The 80/20 for this user is **(a)** parallel review/implement to move faster, **(b)** background agents so things happen off-keyboard, **(c)** notifications so they know when *they're* needed. That's current *and* useful.

### 3. Lean on built-ins first (remind them these already exist)

Before building anything, the gains are mostly already installed:
- **`/code-review ultra`** — deep multi-agent cloud review of the branch/PR.
- **`/loop`** — run a prompt/command on an interval or self-paced.
- **`/schedule`** — cron cloud agents (recurring or one-time).
- **`/deep-research`** — fan-out, fact-checked research reports.
- **`/verify`** — run the app and observe that a change actually works.
- **`/simplify`**, **`/security-review`** — targeted cleanup / security passes.
- The **Workflow** tool — deterministic multi-agent orchestration when a task wants real fan-out.

Don't rebuild these. Point and use.

### 4. The 3 net-new skills worth building (the gaps built-ins don't cover)

These map to the 80/20 and do **not** duplicate a built-in. Build them over a few sessions with experimentation — not all at once:

1. **Orchestrated build** (the modern upgrade to `/branch`) — plan → fan out parallel sub-agents to implement independent pieces → adversarial multi-agent review → verify-by-running. Built-in review exists, but built-in *implementation orchestration* does not. **Biggest single speed win.**
2. **Background watcher / notifier** — wires `/loop` + `/schedule` + Vercel/Gmail MCP into "ping me when X": deploy goes green, a PR needs me, CI breaks. **Off-keyboard progress + notifications.**
3. **Cross-repo standup / status** — reads across the app roster (PROJECTS list + git state) and reports what changed, what's stale, what's next per priority. Schedulable. **Keeps 6 apps moving instead of one.**

### 5. Close every session with ONE concrete next step

Don't end on a list. Pick (with them) a single thing to try *today* — e.g. "run `/code-review ultra` on your current branch and see what a multi-agent pass feels like," or "let's draft skill #2 and test it on a frunk deploy." Small, real, this-session. Encourage. Note what they tried so next `/modernize` builds on it.

## Tone

Encouraging, plain, concrete. They've said the new tooling is "still a little confusing." Assume that. No jargon without a one-line gloss. No pressure to adopt everything. The job is momentum, not a transformation.
