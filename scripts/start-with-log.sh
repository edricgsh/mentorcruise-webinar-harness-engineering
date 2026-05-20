#!/usr/bin/env bash
# Start backend and/or frontend; logs go to /tmp/todo-<branch>-<service>.log
# Ports are read from .env in the repo root — no manual port arguments needed.
# Usage: scripts/start-with-log.sh [backend|frontend|all]

set -e

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
BRANCH=$(git -C "$ROOT" rev-parse --abbrev-ref HEAD 2>/dev/null || echo "nobranch")
BRANCH_SLUG="${BRANCH//\//-}"
ENV_FILE="$ROOT/.env"

if [ ! -f "$ENV_FILE" ]; then
  echo "ERROR: $ENV_FILE not found. Copy .env.example to .env and set your ports."
  exit 1
fi

# Read ports from .env for display purposes only
BACKEND_PORT=$(grep '^PORT=' "$ENV_FILE" | cut -d= -f2)
FRONTEND_PORT=$(grep '^VITE_PORT=' "$ENV_FILE" | cut -d= -f2)

TARGET="${1:-all}"

echo "[start-with-log] branch=$BRANCH  backend=:${BACKEND_PORT:-3001}  frontend=:${FRONTEND_PORT:-5173}"

start_backend() {
  local LOG="/tmp/todo-${BRANCH_SLUG}-backend.log"
  local PID_FILE="/tmp/todo-${BRANCH_SLUG}-backend.pid"
  echo "[backend] log → $LOG"
  cd "$ROOT/backend"
  node index.js >> "$LOG" 2>&1 &
  echo $! > "$PID_FILE"
  echo "[backend] started PID $(cat "$PID_FILE")"
}

start_frontend() {
  local LOG="/tmp/todo-${BRANCH_SLUG}-frontend.log"
  local PID_FILE="/tmp/todo-${BRANCH_SLUG}-frontend.pid"
  echo "[frontend] log → $LOG"
  cd "$ROOT/frontend"
  npm run dev >> "$LOG" 2>&1 &
  echo $! > "$PID_FILE"
  echo "[frontend] started PID $(cat "$PID_FILE")"
}

case "$TARGET" in
  backend)  start_backend ;;
  frontend) start_frontend ;;
  all)      start_backend; start_frontend ;;
  *)        echo "Usage: $0 [backend|frontend|all]"; exit 1 ;;
esac

echo "[start-with-log] done. Logs at /tmp/todo-${BRANCH_SLUG}-*.log"
