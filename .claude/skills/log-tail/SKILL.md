---
name: log-tail
description: Read and tail application logs for the todo app backend and frontend
user-invocable: true
allowed-tools:
  - Bash
  - Read
---

# Log Tail Skill

Read application logs for the todo app. Logs are written to `/tmp/todo-<branch>-<service>.log` when the app is started via the setup script.

## Log File Locations

Logs follow this pattern:
```
/tmp/todo-<branch-name>-backend.log
/tmp/todo-<branch-name>-frontend.log
```

To find the current branch and active log files:
```bash
BRANCH=$(git -C /Users/siehuaigan/project/external/demo_mentorcruise_webinar rev-parse --abbrev-ref HEAD)
echo "Branch: $BRANCH"
ls /tmp/todo-${BRANCH}-*.log 2>/dev/null || echo "No log files found — start the app first"
```

## Starting the App with Logging

Always start the app via the script so logs are captured:
```bash
cd /Users/siehuaigan/project/external/demo_mentorcruise_webinar
scripts/start-with-log.sh all        # both backend and frontend
scripts/start-with-log.sh backend    # backend only
scripts/start-with-log.sh frontend   # frontend only
```

## Common Log Inspection Commands

### Show last 50 lines of backend log
```bash
BRANCH=$(git -C /Users/siehuaigan/project/external/demo_mentorcruise_webinar rev-parse --abbrev-ref HEAD)
tail -50 /tmp/todo-${BRANCH}-backend.log
```

### Show errors only
```bash
BRANCH=$(git -C /Users/siehuaigan/project/external/demo_mentorcruise_webinar rev-parse --abbrev-ref HEAD)
grep -i error /tmp/todo-${BRANCH}-backend.log | tail -20
```

### Show all logs since startup
```bash
BRANCH=$(git -C /Users/siehuaigan/project/external/demo_mentorcruise_webinar rev-parse --abbrev-ref HEAD)
cat /tmp/todo-${BRANCH}-backend.log
```

### Search for a specific request or keyword
```bash
BRANCH=$(git -C /Users/siehuaigan/project/external/demo_mentorcruise_webinar rev-parse --abbrev-ref HEAD)
grep "POST /todos" /tmp/todo-${BRANCH}-backend.log | tail -10
```

## Workflow

1. Confirm log files exist (app must be running via the script)
2. Use `tail` for recent activity, `grep` for specific errors or requests
3. When debugging an API issue, check logs after reproducing the problem
