---
name: start-app
description: Start, stop, restart, and check status of the todo app — port-aware per branch/worktree
user-invocable: true
allowed-tools:
  - Bash
---

# Start App Skill

Manage todo app processes. Ports are automatically resolved from the current git branch so multiple worktrees can run in parallel without conflicts.

## Port Map (scripts/ports.sh)

| Branch | Backend | Frontend |
|---|---|---|
| main | :3001 | :5173 |
| feature/filters | :3002 | :5174 |
| feature/due-dates | :3003 | :5175 |
| feature/priority | :3004 | :5176 |
| any other branch | auto-derived (3100+/5200+) | auto-derived |

## Project Root

```
/Users/siehuaigan/project/external/demo_mentorcruise_webinar
```

Worktrees live at:
```
/Users/siehuaigan/project/external/_worktrees/<branch-slug>/
```

---

## Commands

### Create a new worktree
```bash
cd /Users/siehuaigan/project/external/demo_mentorcruise_webinar
scripts/new-worktree.sh feature/filters
```

### Check status (current branch)
```bash
cd /Users/siehuaigan/project/external/demo_mentorcruise_webinar
scripts/app-ctl.sh status all
```

### Start the app
```bash
scripts/start-with-log.sh all        # both
scripts/start-with-log.sh backend    # backend only
scripts/start-with-log.sh frontend   # frontend only
```

### Stop / Restart
```bash
scripts/app-ctl.sh stop all
scripts/app-ctl.sh restart all
scripts/app-ctl.sh restart backend
```

---

## Health Check

After starting, verify services are up (ports depend on branch):
```bash
BRANCH=$(git rev-parse --abbrev-ref HEAD)
source scripts/ports.sh && resolve_ports "$BRANCH"
curl -s http://localhost:${BACKEND_PORT}/todos | python3 -m json.tool
curl -s -o /dev/null -w "%{http_code}" http://localhost:${FRONTEND_PORT}
```

## Workflow

1. Run `status` to check what's running
2. If dead/stale, run `restart` — script kills old PID and starts fresh with correct ports
3. Health-check the backend endpoint
4. Check logs with the `log-tail` skill if something looks wrong
