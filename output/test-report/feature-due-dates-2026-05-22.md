# API Test Report — Feature 2: Due Dates

**Date**: 2026-05-22  
**Branch**: `feature/due-dates`  
**Worktree**: `/tmp/demo_mentorcruise_webinar/feature-due-dates`  
**Base URL**: `http://localhost:3003`

---

## Summary

| Total | Passed | Failed |
|-------|--------|--------|
| 9     | 8      | 1      |

---

## Test Results

### ✅ GET /todos — initial state
- **Expected**: HTTP 200, empty JSON array
- **Actual**: HTTP 200, `[]`
- **Result**: PASS

---

### ✅ POST /todos — create with due_date
- **Request**: `{ "title": "Buy groceries", "due_date": "2026-06-01" }`
- **Expected**: HTTP 200, response includes `id`, `title`, `completed: false`, `due_date`
- **Actual**: HTTP 200, `{ "id": 1, "title": "Buy groceries", "completed": false, "due_date": "2026-06-01" }`
- **Result**: PASS

---

### ✅ POST /todos — create overdue item (past date)
- **Request**: `{ "title": "Overdue task", "due_date": "2026-01-01" }`
- **Expected**: HTTP 200, `due_date` stored as-is (past date accepted by API)
- **Actual**: HTTP 200, `{ "id": 2, "title": "Overdue task", "completed": false, "due_date": "2026-01-01" }`
- **Result**: PASS
- **Note**: Overdue highlighting is handled on the frontend (date < today renders in red)

---

### ✅ POST /todos — create without due_date
- **Request**: `{ "title": "No due date task" }`
- **Expected**: HTTP 200, `due_date: null`
- **Actual**: HTTP 200, `{ "id": 3, "title": "No due date task", "completed": false, "due_date": null }`
- **Result**: PASS — `due_date` is optional, defaults to `null`

---

### ✅ GET /todos — list all with due_date field
- **Expected**: HTTP 200, array of 3 items, each with `due_date` field
- **Actual**: HTTP 200, all 3 todos returned with correct `due_date` values (`"2026-06-01"`, `"2026-01-01"`, `null`)
- **Result**: PASS

---

### ✅ PATCH /todos/:id — mark completed
- **Request**: `{ "completed": true }` on id=1
- **Expected**: HTTP 200, `{ "ok": true }`
- **Actual**: HTTP 200, `{ "ok": true }`
- **Result**: PASS

---

### ❌ POST /todos — missing title (error case)
- **Request**: `{}`
- **Expected**: HTTP 400 with a structured error response
- **Actual**: HTTP 500, raw HTML stack trace (`SqliteError: NOT NULL constraint failed: todos.title`)
- **Result**: FAIL
- **Notes**: No input validation on the `title` field — the SQLite constraint fires and Express returns an unhandled 500. This is a pre-existing issue not introduced by this feature.

---

### ✅ DELETE /todos/:id — delete overdue item
- **Request**: `DELETE /todos/2`
- **Expected**: HTTP 200, `{ "ok": true }`
- **Actual**: HTTP 200, `{ "ok": true }`
- **Result**: PASS

---

### ✅ GET /todos — verify final state after delete
- **Expected**: 2 remaining todos; deleted item (id=2) gone; id=1 marked completed
- **Actual**: `[{ id:1, title:"Buy groceries", completed:true, due_date:"2026-06-01" }, { id:3, title:"No due date task", completed:false, due_date:null }]`
- **Result**: PASS

---

## Database Verification (SQLite)

### Schema — `PRAGMA table_info(todos)`

| cid | name      | type    | notnull | dflt_value | pk |
|-----|-----------|---------|---------|------------|----|
| 0   | id        | INTEGER | 0       | null       | 1  |
| 1   | title     | TEXT    | 1       | null       | 0  |
| 2   | completed | INTEGER | 1       | 0          | 0  |
| 3   | due_date  | TEXT    | 0       | null       | 0  |

`due_date TEXT` column confirmed present and nullable.

### Final DB state

| id | title              | completed | due_date   |
|----|--------------------|-----------|------------|
| 1  | Buy groceries      | 1         | 2026-06-01 |
| 3  | No due date task   | 0         | null       |

Matches API responses — data fully persisted.

---

## Backend Log Notes

- Backend started cleanly on `http://localhost:3003`
- One `SqliteError: NOT NULL constraint failed: todos.title` logged — expected from the missing-title error test
- No other errors or crashes observed

---

## Observations

1. **Feature working correctly** — `due_date` is accepted on `POST /todos`, stored as `TEXT`, returned on `GET /todos`, and defaults to `null` when omitted.

2. **Missing input validation** (pre-existing bug, not introduced by this feature) — `POST /todos` with no `title` returns HTTP 500 with a raw stack trace instead of HTTP 400. Recommend adding a check like `if (!title) return res.status(400).json({ error: 'title required' })` in `index.js:post /todos`.

3. **Frontend overdue logic** — date comparison (`due_date < today`) uses ISO string lexicographic ordering which is correct for `YYYY-MM-DD` format. Works as intended.

4. **No date validation on backend** — any string is accepted as `due_date`. For production use, consider validating the ISO 8601 format on the server.
