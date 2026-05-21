# Worktree Test Report — 2026-05-21

**Test Date:** 2026-05-21  
**Backends Tested:**
- **main** — http://localhost:4001 | DB: `/Users/siehuaigan/project/external/demo_mentorcruise_webinar/backend/todos.db`
- **feature/filters** — http://localhost:4002 | DB: `/Users/siehuaigan/project/external/_worktrees/feature-filters/backend/todos.db`

---

## Summary Table

| Worktree        | Total Tests | Passed | Failed |
|-----------------|-------------|--------|--------|
| main            | 8           | 7      | 1      |
| feature/filters | 8           | 7      | 1      |
| **Combined**    | **16**      | **14** | **2**  |

> The 1 failure per worktree is the same shared bug: `POST /todos` with an empty body returns HTTP 500 instead of a proper 400 validation error.

---

## Log Inspection

### main backend — `/tmp/todo-main-backend.log`

```
◇ injected env (3) from ../.env // tip: ◈ secrets for agents [www.dotenvx.com]
Backend running on http://localhost:4001
SqliteError: NOT NULL constraint failed: todos.title
    at /Users/siehuaigan/project/external/demo_mentorcruise_webinar/backend/index.js:27:69
    ...
```

- Started correctly on port 4001. ✅
- One error logged: the `SqliteError` from the empty-body POST test. This was triggered during testing and is expected given the bug described below.

### feature/filters backend — `/tmp/todo-feature-filters-backend.log`

```
◇ injected env (3) from ../.env // tip: ⌘ custom filepath { path: '/custom/path/.env' }
Backend running on http://localhost:4002
SqliteError: NOT NULL constraint failed: todos.title
    at /Users/siehuaigan/project/external/_worktrees/feature-filters/backend/index.js:27:69
    ...
```

- Started correctly on port 4002. ✅
- Same `SqliteError` logged from the empty-body POST test.
- Note: The dotenvx tip message differs slightly from main (mentions a custom filepath path hint vs. the agent-secrets hint). This is cosmetic and not a functional issue.

---

## Per-Test Results

### main worktree (http://localhost:4001)

| # | Endpoint | Input | Expected Status | Actual Status | Expected Body | Actual Body | DB Verified | Result |
|---|----------|-------|-----------------|---------------|---------------|-------------|-------------|--------|
| 1 | GET /todos | — | 200, JSON array | 200 | `[]` | `[]` | N/A | ✅ PASS |
| 2 | POST /todos | `{"title":"Main Test Todo"}` | 200, has id/title/completed:false | 200 | `{id, title, completed:false}` | `{"id":1,"title":"Main Test Todo","completed":false}` | Row `1\|Main Test Todo\|0` ✅ | ✅ PASS |
| 3 | PATCH /todos/1 | `{"completed":true}` | 200, `{ok:true}` | 200 | `{ok:true}` | `{"ok":true}` | Row `1\|Main Test Todo\|1` ✅ | ✅ PASS |
| 4 | GET /todos | — | 200, completed:true | 200 | item has `completed:true` | `[{"id":1,"title":"Main Test Todo","completed":true}]` | N/A | ✅ PASS |
| 5 | DELETE /todos/1 | — | 200, `{ok:true}` | 200 | `{ok:true}` | `{"ok":true}` | Table empty ✅ | ✅ PASS |
| 6 | GET /todos | — | 200, `[]` (deleted gone) | 200 | `[]` | `[]` | N/A | ✅ PASS |
| 7 | POST /todos | `{}` (empty body) | 400 (validation error) | **500** | error response | HTML `SqliteError: NOT NULL constraint failed: todos.title` | N/A | ❌ FAIL |
| 8 | Isolation check | Created on main, GET from feature | Not present on feature | N/A | feature returns `[]` | `[]` (correct) | Main DB has row, feature DB empty ✅ | ✅ PASS |

---

### feature/filters worktree (http://localhost:4002)

| # | Endpoint | Input | Expected Status | Actual Status | Expected Body | Actual Body | DB Verified | Result |
|---|----------|-------|-----------------|---------------|---------------|-------------|-------------|--------|
| 1 | GET /todos | — | 200, JSON array | 200 | `[]` | `[]` | N/A | ✅ PASS |
| 2 | POST /todos | `{"title":"Feature Test Todo"}` | 200, has id/title/completed:false | 200 | `{id, title, completed:false}` | `{"id":3,"title":"Feature Test Todo","completed":false}` | Row `3\|Feature Test Todo\|0` ✅ | ✅ PASS |
| 3 | PATCH /todos/3 | `{"completed":true}` | 200, `{ok:true}` | 200 | `{ok:true}` | `{"ok":true}` | Row `3\|Feature Test Todo\|1` ✅ | ✅ PASS |
| 4 | GET /todos | — | 200, completed:true | 200 | item has `completed:true` | `[{"id":3,"title":"Feature Test Todo","completed":true}]` | N/A | ✅ PASS |
| 5 | DELETE /todos/3 | — | 200, `{ok:true}` | 200 | `{ok:true}` | `{"ok":true}` | Table empty ✅ | ✅ PASS |
| 6 | GET /todos | — | 200, `[]` (deleted gone) | 200 | `[]` | `[]` | N/A | ✅ PASS |
| 7 | POST /todos | `{}` (empty body) | 400 (validation error) | **500** | error response | HTML `SqliteError: NOT NULL constraint failed: todos.title` | N/A | ❌ FAIL |
| 8 | Isolation check | Created on main, GET from feature | Not present on feature | N/A | feature returns `[]` | `[]` (correct) | Main DB has row, feature DB empty ✅ | ✅ PASS |

> Note: The feature/filters todo was created with `id:3`, not `id:1`, indicating the feature DB had prior rows that were deleted before testing began. This is normal; SQLite `AUTOINCREMENT` does not reuse IDs.

---

## Isolation Test Detail

**Test:** Create a todo on main (`POST /todos {"title": "Isolation Test Todo - MAIN ONLY"}`), then GET from feature.

| Step | Action | Result |
|------|--------|--------|
| POST to main | Created `{"id":2,"title":"Isolation Test Todo - MAIN ONLY","completed":false}` | ✅ |
| GET from main | Returns `[{"id":2,"title":"Isolation Test Todo - MAIN ONLY","completed":false}]` | ✅ |
| GET from feature | Returns `[]` — todo not visible | ✅ ISOLATED |
| main DB check | `2\|Isolation Test Todo - MAIN ONLY\|0` present | ✅ |
| feature DB check | Table empty | ✅ |
| Cleanup | DELETE /todos/2 on main → `{"ok":true}` 200 | ✅ |

**Conclusion:** The two worktrees use completely separate SQLite databases. Mutations on one are invisible to the other. Database isolation is confirmed.

---

## Bugs Found

### BUG-001: Missing Input Validation on POST /todos — Both Worktrees

**Severity:** Medium  
**Affects:** `main` and `feature/filters` (identical code)  
**Endpoint:** `POST /todos`  
**Reproduction:** Send `POST /todos` with `Content-Type: application/json` and body `{}`  

**Expected:** HTTP 400 with a user-friendly error message such as `{"error": "title is required"}`  
**Actual:** HTTP 500 with an HTML error page exposing internal stack trace:
```
SqliteError: NOT NULL constraint failed: todos.title
    at .../backend/index.js:27:69
```

**Root Cause:** The `POST /todos` handler in `backend/index.js` passes `req.body.title` (which is `undefined` when title is missing) directly to the SQLite INSERT statement. There is no input validation before the DB call. SQLite's `NOT NULL` constraint fires and the unhandled exception bubbles up as a 500.

**Relevant code** (`backend/index.js`, line 26–29):
```js
app.post('/todos', (req, res) => {
  const { title } = req.body;
  const result = db.prepare('INSERT INTO todos (title) VALUES (?)').run(title);
  res.json({ id: result.lastInsertRowid, title, completed: false });
});
```

**Fix recommendation:** Add an early guard before the DB call:
```js
app.post('/todos', (req, res) => {
  const { title } = req.body;
  if (!title || typeof title !== 'string' || title.trim() === '') {
    return res.status(400).json({ error: 'title is required' });
  }
  const result = db.prepare('INSERT INTO todos (title) VALUES (?)').run(title.trim());
  res.json({ id: result.lastInsertRowid, title: title.trim(), completed: false });
});
```

This fix should be applied identically to both worktrees since they share the same backend code.

---

## Additional Observations

1. **Stack trace exposure in production responses:** The 500 error page returns a full Node.js stack trace including absolute file paths (`/Users/siehuaigan/...`). This is a security concern in production — error handlers should not expose internal paths.

2. **No 404 on non-existent PATCH/DELETE:** The `PATCH /todos/:id` and `DELETE /todos/:id` handlers do not check whether the row exists before running the SQL statement. Patching or deleting a non-existent ID silently returns `{"ok":true}` instead of a 404. This was not an explicit test case in this run but is worth noting for future test coverage.

3. **SQLite AUTOINCREMENT gap on feature DB:** The feature/filters DB assigned `id:3` to the first todo created during this test run, indicating rows 1 and 2 previously existed and were deleted. This is expected SQLite behavior but confirms the DB had prior state before testing.
