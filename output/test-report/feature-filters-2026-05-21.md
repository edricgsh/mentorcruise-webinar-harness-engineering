# API Test Report — Feature 1: Filter Tabs

**Date**: 2026-05-21  
**Branch**: feature/filters  
**Backend**: http://localhost:4002  
**Frontend**: http://localhost:5174  

---

## Summary

| Total | Passed | Failed |
|-------|--------|--------|
| 7     | 7      | 0      |

---

## Test Results

### ✅ GET /todos (baseline)
- **Expected**: HTTP 200, JSON array
- **Actual**: HTTP 200, empty array `[]`
- **Result**: PASS

### ✅ POST /todos (create 3 todos)
- **Expected**: HTTP 200, `{ id, title, completed: false }` for each
- **Actual**: IDs 1, 2, 3 created — "Buy milk", "Write tests", "Ship feature"
- **Result**: PASS

### ✅ PATCH /todos/1 — mark completed
- **Expected**: HTTP 200, `{ ok: true }`
- **Actual**: HTTP 200, `{ ok: true }`; DB confirmed `completed = 1` for id=1
- **Result**: PASS

### ✅ GET /todos?status=active
- **Expected**: HTTP 200, only todos with `completed: false`
- **Actual**: HTTP 200, returned ids 2 ("Write tests") and 3 ("Ship feature") — both `completed: false`
- **Result**: PASS

### ✅ GET /todos?status=completed
- **Expected**: HTTP 200, only todos with `completed: true`
- **Actual**: HTTP 200, returned id 1 ("Buy milk") — `completed: true`
- **Result**: PASS

### ✅ GET /todos (all — no filter param)
- **Expected**: HTTP 200, all todos regardless of status
- **Actual**: HTTP 200, returned all 3 todos
- **Result**: PASS

### ✅ DELETE /todos/3
- **Expected**: HTTP 200, `{ ok: true }`; todo removed from DB
- **Actual**: HTTP 200, `{ ok: true }`; DB shows 2 remaining todos (ids 1, 2)
- **Result**: PASS

---

## Database Verification

Final DB state after all mutations:

| id | title         | completed |
|----|---------------|-----------|
| 1  | Buy milk      | 1         |
| 2  | Write tests   | 0         |

Count by status: 1 active, 1 completed. Matches expected state after marking id=1 done and deleting id=3.

---

## Backend Log Notes

- Backend started cleanly on port 4002 (dotenv loaded 3 vars from `../.env`)
- One `SqliteError: NOT NULL constraint failed: todos.title` logged from an earlier test run (missing title POST). This is expected SQLite behaviour — no crash, request failed gracefully.

---

## Observations

- Filter logic uses SQL `WHERE completed = 0/1` as specified — no client-side filtering.
- Unknown `?status=` values (e.g. `?status=foo`) fall through to "all todos" — safe default.
- Frontend tabs (All / Active / Completed) re-fetch from backend on each click and highlight the active tab.
- No regressions on base CRUD (POST / PATCH / DELETE).
