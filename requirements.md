# Todo App — Feature Requirements

Base app: Vite (React) frontend + Express backend + SQLite.  
Current state: create, toggle, delete todos. Title + completed only.

---

## Feature 1 — Filter tabs (branch: `feature/filters`)

Show three tabs above the todo list: **All**, **Active**, **Completed**.  
Clicking a tab fetches the filtered list from the backend — no client-side filtering.

- **Backend:** `GET /todos` accepts an optional `?status=active|completed` query param. Filter is applied in SQL (`WHERE completed = 0/1`). No param returns all todos.
- **Frontend:** render the three tabs; on tab click, re-fetch with `?status=<value>`. Highlight the active tab.

**Scope:** backend query param + SQL WHERE + small frontend change, ~25 lines total.

---

## Feature 2 — Due dates (branch: `feature/due-dates`)

Add an optional due date to each todo.

- **Backend:** add `due_date TEXT` column to `todos` table. Accept `due_date` on `POST /todos`. Return it on `GET /todos`.
- **Frontend:** add a date `<input>` next to the title input. Show the due date on each todo item. Overdue items (past today) show the date in red.

**Scope:** backend schema change + small frontend addition, ~40 lines total.

---

## Feature 3 — Priority (branch: `feature/priority`)

Add a priority level (Low / Medium / High) to each todo.

- **Backend:** add `priority TEXT DEFAULT 'medium'` column. Accept it on `POST /todos`. Return it on `GET /todos`. `GET /todos` sorts results so High items appear first (`ORDER BY CASE priority WHEN 'high' THEN 0 WHEN 'medium' THEN 1 ELSE 2 END`).
- **Frontend:** add a `<select>` dropdown in the add form. Show a colored badge (green / yellow / red) on each todo item.

**Scope:** backend schema change + SQL ORDER BY + small frontend addition, ~40 lines total.

---

## Notes

- Each feature lives on its own git branch and worktree so they can be built and demoed in parallel.
- Port assignments: filters → 4002/5174, due-dates → 4003/5175, priority → 4004/5176.
- Delete `backend/todos.db` in a worktree before first start whenever a schema column is added.
