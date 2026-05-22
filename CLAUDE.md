# Todo App — Claude Context

Simple todo app built for a MentorCruise webinar to demo harness engineering. Vite (React) frontend + Express backend + SQLite.

---

## Repo structure

```
demo_mentorcruise_webinar/   ← main repo (branch: main)
  backend/                   ← Express + better-sqlite3
  frontend/                  ← Vite React
  scripts/                   ← control scripts (see below)
  .claude/skills/            ← AI skills
  .env                       ← NOT committed; ports for this worktree
  .env.example               ← committed template

/tmp/demo_mentorcruise_webinar/  ← git worktrees live here (cleared on reboot)
  feature-filters/               ← branch: feature/filters
  feature-due-dates/             ← branch: feature/due-dates
```

---

## Port setup — critical

Ports are **not hardcoded**. Each worktree has its own `.env` at the repo root. Both backend and frontend read from it automatically — you never pass ports manually.

```
PORT=<n>              → Express listens here (read via dotenv)
VITE_PORT=<n>         → Vite dev server listens here
VITE_API_URL=http://localhost:<PORT>  → injected into React bundle
```

**Port map** (also in `scripts/new-worktree.sh` RESERVED table):

| Branch | Backend | Frontend |
|---|---|---|
| main | 4001 | 5173 |
| feature/filters | 4002 | 5174 |
| feature/due-dates | 4003 | 5175 |
| feature/priority | 4004 | 5176 |

> **Why 4001 not 3001 for main?** Port 3001 was already occupied by another process on this machine (a Next.js app). If you're on a fresh machine, 3001 is free and you can use it — just update `.env`.

> **Before starting**: always run `lsof -iTCP:<port> -sTCP:LISTEN` to confirm the port is free. If not, update `.env` to a free port.

---

## Starting the app

```bash
# Start both services (reads ports from .env automatically)
scripts/start-with-log.sh all

# Or individually
scripts/start-with-log.sh backend
scripts/start-with-log.sh frontend
```

Logs go to `/tmp/todo-<branch-slug>-<service>.log` (slashes in branch names become dashes).

```bash
# Status / stop / restart
scripts/app-ctl.sh status all
scripts/app-ctl.sh stop all
scripts/app-ctl.sh restart backend
```

---

## Running two features in parallel

```bash
# 1. Create a new worktree (writes .env, runs npm install, prints ports)
scripts/new-worktree.sh feature/my-feature

# 2. cd into it and start
cd /tmp/demo_mentorcruise_webinar/feature-my-feature
scripts/start-with-log.sh all
```

Each worktree is fully isolated — separate node_modules, separate `.env`, separate `todos.db`.

After git-merging new commits into a worktree (`git merge main`), always run `npm install` in `backend/` and `frontend/` — package.json may have changed and node_modules are not shared.

---

## Known gotchas

1. **Stale port after crash** — if a backend crashes, its port may stay bound. Use `lsof -ti :<port> | xargs kill` to clear it before restarting.

2. **Branch name with `/` breaks file paths** — the scripts slugify branch names (`feature/filters` → `feature-filters`) for PID and log files. This is already handled in `start-with-log.sh` and `app-ctl.sh` via `BRANCH_SLUG`.

3. **dotenv not installed after worktree creation from old commit** — if you create a worktree from a commit before dotenv was added, `npm install` in the worktree's `backend/` will be needed even if `new-worktree.sh` already ran it. Run `git merge main` then `npm install` in `backend/`.

4. **`CREATE TABLE IF NOT EXISTS` won't add new columns** — if a feature branch adds a column (e.g. `due_date`), delete the old `todos.db` in that worktree's `backend/` before starting, so the table is recreated fresh.

5. **`.env` is gitignored** — each worktree needs its own `.env`. `new-worktree.sh` writes it automatically. For the main repo on a fresh clone, copy `.env.example` to `.env` and set ports.

---

## Skills available

| Skill | Purpose |
|---|---|
| `sqlite-inspector` | Query `backend/todos.db` — `node scripts/db-inspect.js <shorthand\|sql>` |
| `log-tail` | Read `/tmp/todo-<branch-slug>-backend.log` etc. |
| `start-app` | Start / stop / restart / status via `scripts/app-ctl.sh` |
| `api-test` | curl-based CRUD tests + report saved to `output/test-report/` |
| `worktree` | Create and manage git worktrees for parallel development |

---

## Fresh start checklist

1. `git clone` or confirm you're in the right directory
2. Copy `.env.example` → `.env`, check ports are free (`lsof`)
3. `cd backend && npm install`
4. `cd frontend && npm install`
5. `scripts/start-with-log.sh all`
6. Verify: `curl http://localhost:<PORT>/todos`
7. To add a parallel feature: `scripts/new-worktree.sh <branch>`
