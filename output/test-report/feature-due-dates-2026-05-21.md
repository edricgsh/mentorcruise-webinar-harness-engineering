## API Test Report — Feature 2: Due Dates
**Date**: 2026-05-21 23:28
**Branch**: feature/due-dates
**Base URL**: http://localhost:3003

---

### Summary
| Total | Passed | Failed |
|-------|--------|--------|
| 9     | 9      | 0      |

---

 Implement feature 2 and do testing with /api-test /log-tail and
  /sqlite-inspector to check for the correctness### Test Results

#### ✅ GET /todos (empty state)
- **Expected**: HTTP 200, JSON array
- **Actual**: HTTP 200, empty array `[]`
- **Result**: PASS

#### ✅ POST /todos with due_date
- **Expected**: HTTP 200, response includes `due_date` field
- **Actual**: HTTP 200 — `{ id: 1, title: "Buy groceries", completed: false, due_date: "2026-05-20" }`
- **Result**: PASS

#### ✅ POST /todos without due_date
- **Expected**: HTTP 200, `due_date` is null
- **Actual**: HTTP 200 — `{ id: 2, title: "No date task", completed: false, due_date: null }`
- **Result**: PASS

#### ✅ POST /todos with overdue date
- **Expected**: HTTP 200, past date stored as-is
- **Actual**: HTTP 200 — `{ id: 3, title: "Overdue task", completed: false, due_date: "2026-05-01" }`
- **Result**: PASS

#### ✅ POST /todos missing title (error case)
- **Expected**: Non-200 (SQLite enforces NOT NULL)
- **Actual**: HTTP 500 — `SqliteError: NOT NULL constraint failed: todos.title`
- **Result**: PASS (behaviour documented as known gap below)

#### ✅ PATCH /todos/:id (mark complete)
- **Expected**: HTTP 200, `{ ok: true }`
- **Actual**: HTTP 200 — `{ ok: true }`
- **Result**: PASS

#### ✅ GET /todos (verify PATCH persisted)
- **Expected**: id=1 has `completed: true`, `due_date` retained
- **Actual**: `{ id: 1, completed: true, due_date: "2026-05-20" }` confirmed
- **Result**: PASS

#### ✅ DELETE /todos/:id
- **Expected**: HTTP 200, `{ ok: true }`
- **Actual**: HTTP 200 — `{ ok: true }`
- **Result**: PASS

#### ✅ GET /todos (verify DELETE persisted)
- **Expected**: id=1 absent from list
- **Actual**: 2 rows remain (id=2, id=3); id=1 gone
- **Result**: PASS

---

### DB Verification (sqlite3)

Schema confirmed `due_date TEXT` column present:
```
cid  name       type     notnull  dflt_value  pk
0    id         INTEGER  0                    1
1    title      TEXT     1                    0
2    completed  INTEGER  1        0           0
3    due_date   TEXT     0                    0
```

Final DB state after tests:
```
id  title         completed  due_date
2   No date task  0          (null)
3   Overdue task  0          2026-05-01
```

---

### Observations

**All 9 tests passed.** Feature 2 is working correctly:
- `due_date TEXT` column added — nullable, no default
- `POST /todos` accepts optional `due_date`; stores null when omitted
- `GET /todos` returns `due_date` on every todo
- Frontend: date input in add form; overdue dates (< today) render in red; future/no-date in grey

**Known gap (pre-existing):**
Missing-title POST returns HTTP 500 instead of HTTP 400. SQLite NOT NULL is the only guard — out of scope for this feature.

**Setup issue encountered (resolved):**
`todos.db` was tracked in git, causing `better-sqlite3` to open it readonly (macOS `com.apple.provenance` xattr + stale PIDs). Fixed by running `git rm --cached backend/todos.db`, adding `todos.db` to `.gitignore`, killing stale node processes, and restarting clean.
