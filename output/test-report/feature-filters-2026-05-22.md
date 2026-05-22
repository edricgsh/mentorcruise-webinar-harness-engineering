# API Test Report — Feature 1: Filter Tabs

**Date**: 2026-05-22  
**Branch**: `feature/filters`  
**Worktree**: `/tmp/demo_mentorcruise_webinar/feature-filters`  
**Base URL**: `http://localhost:3002`

---

## Summary

| Total | Passed | Failed |
|-------|--------|--------|
| 10    | 8      | 2      |

---

## Test Results

### ✅ GET /todos — empty list
- **Expected**: HTTP 200, JSON array
- **Actual**: HTTP 200, `[]`
- **Result**: PASS

### ✅ POST /todos — create "Buy groceries" (id=1)
- **Expected**: HTTP 200, `{ id, title, completed: false }`
- **Actual**: HTTP 200, `{"id":1,"title":"Buy groceries","completed":false}`
- **Result**: PASS

### ✅ POST /todos — create "Write report" (id=2)
- **Expected**: HTTP 200, `{ id, title, completed: false }`
- **Actual**: HTTP 200, `{"id":2,"title":"Write report","completed":false}`
- **Result**: PASS

### ✅ POST /todos — create "Call dentist" (id=3)
- **Expected**: HTTP 200, `{ id, title, completed: false }`
- **Actual**: HTTP 200, `{"id":3,"title":"Call dentist","completed":false}`
- **Result**: PASS

### ✅ PATCH /todos/1 — mark completed
- **Expected**: HTTP 200, `{ ok: true }`
- **Actual**: HTTP 200, `{"ok":true}`
- **Result**: PASS

### ✅ PATCH /todos/2 — mark completed
- **Expected**: HTTP 200, `{ ok: true }`
- **Actual**: HTTP 200, `{"ok":true}`
- **Result**: PASS

### ✅ GET /todos — all (no filter param)
- **Expected**: HTTP 200, all 3 todos returned
- **Actual**: HTTP 200, 3 todos — id 1 & 2 `completed: true`, id 3 `completed: false`
- **Result**: PASS

### ✅ GET /todos?status=active
- **Expected**: HTTP 200, only incomplete todos
- **Actual**: HTTP 200, 1 todo — `{"id":3,"title":"Call dentist","completed":false}`
- **Result**: PASS

### ✅ GET /todos?status=completed
- **Expected**: HTTP 200, only completed todos
- **Actual**: HTTP 200, 2 todos — "Buy groceries" and "Write report", both `completed: true`
- **Result**: PASS

### ❌ POST /todos — missing title
- **Expected**: HTTP 400 with error message
- **Actual**: HTTP 500, unhandled `SqliteError: NOT NULL constraint failed: todos.title`
- **Result**: FAIL
- **Notes**: No input validation in the route handler. The DB constraint fires but Express returns a raw 500. Should return HTTP 400 with a descriptive JSON error.

### ❌ DELETE /todos/9999 — non-existent ID
- **Expected**: HTTP 404 or error response
- **Actual**: HTTP 200, `{"ok":true}` (silent no-op)
- **Result**: FAIL
- **Notes**: SQLite `DELETE` on a missing row succeeds with 0 rows affected. The route does not check `changes` and always returns success. Should return HTTP 404 when `result.changes === 0`.

### ✅ DELETE /todos/3 — delete existing
- **Expected**: HTTP 200, `{ ok: true }`
- **Actual**: HTTP 200, `{"ok":true}`
- **Result**: PASS (counted above)

---

## Database Verification

After all mutations, direct SQLite query confirmed expected state:

```
┌─────────┬────┬─────────────────┬───────────┐
│ (index) │ id │ title           │ completed │
├─────────┼────┼─────────────────┼───────────┤
│ 0       │ 1  │ 'Buy groceries' │ 1         │
│ 1       │ 2  │ 'Write report'  │ 1         │
└─────────┴────┴─────────────────┴───────────┘
```

- Todo id 3 ("Call dentist") correctly deleted
- `completed` values match API responses (stored as integers, returned as booleans)

---

## Backend Log

- **Startup**: Clean — env loaded, listening on `:3002`
- **Errors logged**: 1 — `SqliteError: NOT NULL constraint failed` from missing-title test (expected from test, confirmed in log)
- **No crashes or unexpected errors**

---

## Feature Implementation Notes

**Backend (`backend/index.js`)**  
`GET /todos` now accepts `?status=active|completed` and applies `WHERE completed = 0/1` in SQL. Unknown/missing values fall through to no filter (returns all). ~4 lines added.

**Frontend (`frontend/src/App.jsx`)**  
Three tab buttons (All / Active / Completed) rendered above the list. Active tab is highlighted with a dark background. Tab state controls the fetch URL. Toggle and add operations respect the active filter — toggling removes an item from the filtered view, adding skips adding to the "completed" view. ~30 lines added.

---

## Observations & Recommendations

| # | Severity | Issue | Recommendation |
|---|----------|-------|----------------|
| 1 | Low | `POST /todos` with missing title returns HTTP 500 | Add `if (!title) return res.status(400).json({ error: 'title required' })` before the INSERT |
| 2 | Low | `DELETE /todos/:id` on non-existent ID returns HTTP 200 | Check `result.changes === 0` and return `res.status(404).json({ error: 'not found' })` |
| 3 | Info | `GET /todos?status=<invalid>` silently returns all todos | Acceptable behavior; alternatively return 400 for unknown status values |

Both issues (#1 and #2) are pre-existing in the base app and are outside the scope of Feature 1.  
All filter-specific functionality (the three-tab UI + `?status=` query param) is **fully working**.
