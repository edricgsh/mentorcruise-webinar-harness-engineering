---
name: api-test
description: Test the todo app REST API endpoints and produce a test report
user-invocable: true
allowed-tools:
  - Bash
  - Write
---

# API Test Skill

Test the todo app's Express API and produce a structured report.

## Configuration

| Config | Value |
|---|---|
| Base URL | `http://localhost:3001` |
| No auth required | All endpoints are public |

```bash
BASE_URL="http://localhost:3001"
```

## Endpoints Under Test

| Method | Path | Description |
|---|---|---|
| GET | /todos | List all todos |
| POST | /todos | Create a todo (`{ title }`) |
| PATCH | /todos/:id | Toggle completed (`{ completed: bool }`) |
| DELETE | /todos/:id | Delete a todo |

---

## Test Patterns

### GET /todos — list all
```bash
STATUS=$(curl -s -o /tmp/todos.json -w "%{http_code}" http://localhost:3001/todos)
echo "HTTP: $STATUS"
cat /tmp/todos.json | python3 -m json.tool
```
**Verify**: HTTP 200, response is a JSON array.

### POST /todos — create
```bash
STATUS=$(curl -s -o /tmp/create.json -w "%{http_code}" -X POST http://localhost:3001/todos \
  -H "Content-Type: application/json" \
  -d '{"title":"Test todo"}')
echo "HTTP: $STATUS"
cat /tmp/create.json | python3 -m json.tool
TODO_ID=$(cat /tmp/create.json | python3 -c "import sys,json; print(json.load(sys.stdin)['id'])")
echo "Created ID: $TODO_ID"
```
**Verify**: HTTP 200, response has `id`, `title`, `completed: false`.

### POST /todos — missing title (error case)
```bash
STATUS=$(curl -s -o /tmp/err.json -w "%{http_code}" -X POST http://localhost:3001/todos \
  -H "Content-Type: application/json" \
  -d '{}')
echo "HTTP: $STATUS"
cat /tmp/err.json
```
**Verify**: Should not create a todo with empty title.

### PATCH /todos/:id — mark complete
```bash
STATUS=$(curl -s -o /tmp/patch.json -w "%{http_code}" -X PATCH http://localhost:3001/todos/$TODO_ID \
  -H "Content-Type: application/json" \
  -d '{"completed":true}')
echo "HTTP: $STATUS"
cat /tmp/patch.json | python3 -m json.tool
```
**Verify**: HTTP 200, `{ ok: true }`.

### DB verification after PATCH
```bash
bun /Users/siehuaigan/project/external/demo_mentorcruise_webinar/scripts/db-inspect.js \
  "SELECT * FROM todos WHERE id = $TODO_ID"
```
**Verify**: `completed = 1` in database.

### DELETE /todos/:id
```bash
STATUS=$(curl -s -o /tmp/delete.json -w "%{http_code}" -X DELETE http://localhost:3001/todos/$TODO_ID)
echo "HTTP: $STATUS"
cat /tmp/delete.json | python3 -m json.tool
```
**Verify**: HTTP 200, `{ ok: true }`.

### DB verification after DELETE
```bash
bun /Users/siehuaigan/project/external/demo_mentorcruise_webinar/scripts/db-inspect.js \
  "SELECT * FROM todos WHERE id = $TODO_ID"
```
**Verify**: 0 rows returned.

---

## Test Report Format

After running all tests, write report to:
```
output/test-report/<slug>-<date>.md
```

Example:
```bash
mkdir -p /Users/siehuaigan/project/external/demo_mentorcruise_webinar/output/test-report
```

Report structure:
```
## API Test Report
**Date**: YYYY-MM-DD HH:MM
**Base URL**: http://localhost:3001

### Summary
| Total | Passed | Failed |
|-------|--------|--------|
| N     | N      | N      |

### Test Results

#### ✅ GET /todos
- **Expected**: HTTP 200, JSON array
- **Actual**: HTTP 200, array with N items
- **Result**: PASS

#### ❌ POST /todos (missing title)
- **Expected**: HTTP 400
- **Actual**: HTTP 500
- **Result**: FAIL
- **Notes**: No input validation on title field

### Observations
[Bugs found, edge cases, recommendations]
```

---

## Workflow

1. Confirm backend is running: `curl -s http://localhost:3001/todos`
2. Run happy path tests in order: GET → POST → PATCH → DELETE
3. Run error path tests: missing fields, non-existent IDs
4. After each mutation, verify with `sqlite-inspector` skill
5. Write report to `output/test-report/`
