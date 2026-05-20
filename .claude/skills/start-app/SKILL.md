---
name: start-app
description: Start, stop, restart, and check status of the todo app backend and frontend
user-invocable: true
allowed-tools:
  - Bash
---

# Start App Skill

Manage the todo app processes. All commands use `scripts/app-ctl.sh`.

## Project Root

```
/Users/siehuaigan/project/external/demo_mentorcruise_webinar
```

- **Backend**: Express on port `3001` (`backend/index.js`)
- **Frontend**: Vite on port `5173` (`frontend/`)

## Commands

### Check if app is running
```bash
cd /Users/siehuaigan/project/external/demo_mentorcruise_webinar
scripts/app-ctl.sh status all
```

### Start the app (with logging)
```bash
cd /Users/siehuaigan/project/external/demo_mentorcruise_webinar
scripts/start-with-log.sh all
```

### Stop the app
```bash
cd /Users/siehuaigan/project/external/demo_mentorcruise_webinar
scripts/app-ctl.sh stop all
```

### Restart the app
```bash
cd /Users/siehuaigan/project/external/demo_mentorcruise_webinar
scripts/app-ctl.sh restart all
```

### Target a single service
```bash
scripts/app-ctl.sh restart backend
scripts/app-ctl.sh restart frontend
scripts/app-ctl.sh status backend
```

## Health Check

After starting, verify the backend is up:
```bash
curl -s http://localhost:3001/todos | python3 -m json.tool
```

Verify the frontend is up:
```bash
curl -s -o /dev/null -w "%{http_code}" http://localhost:5173
```

## Workflow

1. Run `status` to check current state
2. If a process is dead or stale, run `restart` — the script kills the old PID and starts fresh
3. After restart, run the health check to confirm the backend responds
4. Check logs via the `log-tail` skill if something looks wrong
