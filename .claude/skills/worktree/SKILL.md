---
name: worktree
description: Create and manage git worktrees for parallel local development. Each worktree gets its own .env with unique ports so backend and frontend run without conflicts.
user-invocable: true
allowed-tools:
  - Bash
  - Read
---

# Worktree Skill

Spin up isolated git worktrees for parallel development. Each worktree gets a `.env` file with unique ports — just start the app normally and the right ports are used automatically.

## How it works

- `.env` lives at the repo root of each worktree
- Backend reads it via `dotenv` on startup
- Vite reads it natively (configured to look one level up from `frontend/`)
- No manual port arguments needed — just `scripts/start-with-log.sh all`

## Port assignments (scripts/new-worktree.sh)

| Branch | Backend | Frontend |
|---|---|---|
| main | :3001 | :5173 |
| feature/filters | :3002 | :5174 |
| feature/due-dates | :3003 | :5175 |
| feature/priority | :3004 | :5176 |
| any other branch | auto (3100+) | auto (5200+) |

To add a new explicit assignment, edit the `RESERVED` map in `scripts/new-worktree.sh`.

---

## Create a new worktree

```bash
cd /Users/siehuaigan/project/external/demo_mentorcruise_webinar
scripts/new-worktree.sh feature/filters
```

This will:
1. Create a git branch `feature/filters`
2. Check out the worktree at `/tmp/demo_mentorcruise_webinar/feature-filters/`
3. Write `.env` with the assigned ports
4. Run `npm install` for backend and frontend

Output looks like:
```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  Worktree ready
  branch:   feature/filters
  path:     /tmp/demo_mentorcruise_webinar/feature-filters
  backend:  http://localhost:3002
  frontend: http://localhost:5174
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

---

## Start the app in a worktree

> **CRITICAL**: Always `cd` into the worktree directory before running scripts.
> Running from the main repo starts the backend from the wrong folder, opening
> the main repo's `todos.db` — causing "attempt to write a readonly database".

```bash
cd /tmp/demo_mentorcruise_webinar/feature-filters
scripts/start-with-log.sh all
```

The `.env` in that directory is picked up automatically — no extra arguments.

---

## Check .env for current worktree

To see what ports this worktree is using:

```bash
cat /Users/siehuaigan/project/external/demo_mentorcruise_webinar/.env
# or from inside any worktree:
cat .env
```

---

## List all active worktrees

```bash
git -C /Users/siehuaigan/project/external/demo_mentorcruise_webinar worktree list
```

## Remove a worktree

```bash
git -C /Users/siehuaigan/project/external/demo_mentorcruise_webinar worktree remove /tmp/demo_mentorcruise_webinar/feature-filters
```

---

## Worktree locations

- **Main repo**: `/Users/siehuaigan/project/external/demo_mentorcruise_webinar`
- **Worktrees**: `/tmp/demo_mentorcruise_webinar/<branch-slug>/` (cleared on reboot)

Each worktree is a full checkout — you can open it in a separate editor window and work independently.
