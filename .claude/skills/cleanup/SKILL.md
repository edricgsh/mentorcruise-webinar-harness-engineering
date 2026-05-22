---
name: cleanup
description: >
  Removes all git worktrees under /tmp/demo_mentorcruise_webinar/, deletes their branches, and
  clears output/test-report/ files. Prints a summary of everything removed.
  No confirmation prompts — safe to run between webinar demos for a clean slate.
  Trigger phrases: "clean up", "reset the demo", "remove worktrees",
  "clear test reports", "cleanup everything".
argument-hint: "(no arguments needed)"
allowed-tools: Bash(git *), Bash(rm /tmp/*), Bash(mv *), Bash(mkdir *), Bash(ls *), Bash(find *), Bash(lsof *), Bash(kill *)
---

# Cleanup

Remove all worktrees, their branches, and test report output for a clean demo slate.

## Steps

### 1. Discover worktrees
```bash
git -C /Users/siehuaigan/project/external/demo_mentorcruise_webinar worktree list
```
Note every path and branch listed (skip the main repo entry).

### 2. Stop any running processes on worktree ports
Kill any processes on ports 4002–4004 and 5174–5176 so they don't hold locks:
```bash
for port in 4002 4003 4004 5174 5175 5176; do
  lsof -ti:$port | xargs kill -9 2>/dev/null || true
done
```

### 3. Remove each worktree
For each worktree path found in step 1, run:
```bash
git -C /Users/siehuaigan/project/external/demo_mentorcruise_webinar worktree remove --force <path>
```
After all worktrees are removed, prune stale refs:
```bash
git -C /Users/siehuaigan/project/external/demo_mentorcruise_webinar worktree prune
```

### 4. Delete the worktree branches
For each branch that was checked out in a worktree (e.g. feature/filters, feature/due-dates, feature/priority):
```bash
git -C /Users/siehuaigan/project/external/demo_mentorcruise_webinar branch -D <branch>
```
Never delete `main`.

### 5. Archive the /tmp/demo_mentorcruise_webinar directory
Move it to a timestamped archive folder rather than deleting it:
```bash
ARCHIVE=~/demo-worktree-archive/$(date +%Y%m%d-%H%M%S)
mkdir -p "$ARCHIVE"
mv /tmp/demo_mentorcruise_webinar "$ARCHIVE/" 2>/dev/null || true
echo "Archived worktree dir to $ARCHIVE"
```

### 6. Archive test report output
Move reports to a timestamped archive instead of deleting them:
```bash
REPORT_SRC=/Users/siehuaigan/project/external/demo_mentorcruise_webinar/output/test-report
REPORT_ARCHIVE=~/demo-worktree-archive/test-reports/$(date +%Y%m%d-%H%M%S)
mkdir -p "$REPORT_ARCHIVE"
mv "$REPORT_SRC"/*.md "$REPORT_ARCHIVE/" 2>/dev/null || true
echo "Archived test reports to $REPORT_ARCHIVE"
```

### 7. Clear PID and log files
```bash
rm -f /tmp/todo-feature-*.log /tmp/todo-feature-*.pid
```

### 8. Print summary
List what was removed:
- Worktree paths removed
- Branches deleted
- Test report files deleted
- Log/PID files cleared

## Error Handling
- If `worktree remove` fails due to uncommitted changes, use `--force` (already included).
- If a branch deletion fails because it's checked out, it's likely `main` — skip it.
- If the /tmp/demo_mentorcruise_webinar directory has leftover untracked files after worktree removal, the archive step (step 5) will move them all together.
- If no worktrees or reports exist, report "nothing to clean up" and exit cleanly.
