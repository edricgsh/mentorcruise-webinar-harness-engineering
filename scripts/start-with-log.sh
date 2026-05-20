#!/usr/bin/env bash
# Starts the backend and tails its output to /tmp/todo-<branch>.log
# Usage: scripts/start-with-log.sh [backend|frontend|all]

set -e

BRANCH=$(git -C "$(dirname "$0")/.." rev-parse --abbrev-ref HEAD 2>/dev/null || echo "nobranch")
ROOT="$(cd "$(dirname "$0")/.." && pwd)"

TARGET="${1:-all}"

start_backend() {
  LOG="/tmp/todo-${BRANCH}-backend.log"
  echo "[start-with-log] backend log → $LOG"
  cd "$ROOT/backend"
  node index.js >> "$LOG" 2>&1 &
  echo $! > /tmp/todo-backend.pid
  echo "[start-with-log] backend PID $(cat /tmp/todo-backend.pid)"
}

start_frontend() {
  LOG="/tmp/todo-${BRANCH}-frontend.log"
  echo "[start-with-log] frontend log → $LOG"
  cd "$ROOT/frontend"
  npm run dev >> "$LOG" 2>&1 &
  echo $! > /tmp/todo-frontend.pid
  echo "[start-with-log] frontend PID $(cat /tmp/todo-frontend.pid)"
}

case "$TARGET" in
  backend)  start_backend ;;
  frontend) start_frontend ;;
  all)      start_backend; start_frontend ;;
  *)        echo "Usage: $0 [backend|frontend|all]"; exit 1 ;;
esac

echo "[start-with-log] Done. Logs at /tmp/todo-${BRANCH}-*.log"
