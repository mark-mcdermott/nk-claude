---
name: watch
description: /watch <target> notify when <condition> — background watcher: polls a deploy / PR / CI / endpoint and notifies when something needs me (uses Monitor, /loop, /schedule, gh, Vercel/Gmail MCP)
usage: /watch <what to watch> — notify when <condition> [via push|email]
examples:
  - /watch the frunk vercel deploy — notify me when it's green or fails
  - /watch open PRs on no-dinos.com — ping me when one is mergeable
  - /watch CI on this branch — email me if it breaks
allowed-tools:
  - Bash(gh:*)
  - Bash(git:*)
  - Bash(curl:*)
  - Read
  - Glob
  - Grep
  - ScheduleWakeup
  - PushNotification
  - Monitor
---

# Watch (background notifier)

Set up an unattended watch so progress happens off-keyboard and you only get pulled in when **you're** actually needed. Parse three things from the request:
1. **Target** — what to watch (a Vercel deploy, a GitHub PR / PR queue, CI on a branch, an endpoint's health).
2. **Condition** — when to notify (deploy green/failed, PR mergeable / needs review, CI red, endpoint down).
3. **Notify via** — push notification (default), email (Gmail MCP), or a message.

## Pick the mechanism
- **This session, short-lived** (minutes–an hour): poll with the **Monitor** tool or a background Bash loop, and use **`ScheduleWakeup`** to re-check on an interval without burning context. Notify when the condition hits.
- **Recurring or long-lived** (survives this session): set up a cloud cron via **`/schedule`**, or a self-paced **`/loop`**, that re-runs the check and notifies.

## How to check each target (read-only)
- **Vercel deploy:** Vercel MCP (deployment status); else poll the production URL for the new build / a deploy hook.
- **GitHub PR / queue / CI:** `gh pr list --json ...`, `gh pr checks`, `gh run list` — read status only.
- **Endpoint health:** `curl -sS -o /dev/null -w '%{http_code}'`.

## Notify
- Default: **`PushNotification`** with a one-line status + the relevant URL.
- If the user asked for email: send via the **Gmail MCP**.
- Always include the next action if one's needed (e.g. "PR #42 is mergeable — review it", "frunk deploy failed — check the build log").

## Rules
- **Read-only on the watched thing** — never merge, deploy, or mutate as a side effect of watching; only observe and notify.
- Confirm the watch back to the user (target · condition · cadence · notify method) so they know it's armed, and tell them how to stop it (`/schedule` list/delete, or cancel the loop).
- Stop watching once the condition fires, unless asked to keep watching.
