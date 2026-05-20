---
name: sqlite-inspector
description: Inspect the SQLite database for the todo app — list tables, query todos, verify data
user-invocable: true
allowed-tools:
  - Bash
  - Read
---

# SQLite Inspector Skill

Inspect the todo app's SQLite database directly.

## Database Location

- **File**: `/Users/siehuaigan/project/external/demo_mentorcruise_webinar/backend/todos.db`
- **Engine**: better-sqlite3 (SQLite 3)

The database file is created automatically when the backend starts. If it doesn't exist yet, start the backend first.

## How to Query

Use the inspector script with bun or node:

```bash
cd /Users/siehuaigan/project/external/demo_mentorcruise_webinar
bun scripts/db-inspect.js "<SQL>"
```

Or pass a named query shorthand:

```bash
bun scripts/db-inspect.js tables        # list all tables
bun scripts/db-inspect.js todos         # all todos
bun scripts/db-inspect.js pending       # incomplete todos only
bun scripts/db-inspect.js done          # completed todos only
```

## Common Queries

### List all tables
```bash
bun scripts/db-inspect.js tables
```

### Show all todos
```bash
bun scripts/db-inspect.js todos
```

### Count todos by status
```bash
bun scripts/db-inspect.js "SELECT completed, COUNT(*) as count FROM todos GROUP BY completed"
```

### Find a specific todo by ID
```bash
bun scripts/db-inspect.js "SELECT * FROM todos WHERE id = 1"
```

### Show schema of todos table
```bash
bun scripts/db-inspect.js "PRAGMA table_info(todos)"
```

## Workflow

1. Run a query to understand current DB state
2. Cross-check with API response when debugging
3. After mutations (POST/PATCH/DELETE), re-query to confirm persistence
