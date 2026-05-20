#!/usr/bin/env bash
# Control todo app processes for the current worktree/branch.
# Ports are read from .env — no manual port arguments needed.
# Usage: scripts/app-ctl.sh <status|start|stop|restart> [backend|frontend|all]

set -e

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
BRANCH=$(git -C "$ROOT" rev-parse --abbrev-ref HEAD 2>/dev/null || echo "nobranch")
BRANCH_SLUG="${BRANCH//\//-}"
ENV_FILE="$ROOT/.env"

if [ ! -f "$ENV_FILE" ]; then
  echo "ERROR: $ENV_FILE not found. Copy .env.example to .env and set your ports."
  exit 1
fi

BACKEND_PORT=$(grep '^PORT=' "$ENV_FILE" | cut -d= -f2)
FRONTEND_PORT=$(grep '^VITE_PORT=' "$ENV_FILE" | cut -d= -f2)

CMD="${1:-status}"
TARGET="${2:-all}"

pid_file() { echo "/tmp/todo-${BRANCH_SLUG}-${1}.pid"; }
log_file()  { echo "/tmp/todo-${BRANCH_SLUG}-${1}.log"; }

is_alive() {
  local pf; pf=$(pid_file "$1")
  [ ! -f "$pf" ] && echo "not started" && return
  local pid; pid=$(cat "$pf")
  kill -0 "$pid" 2>/dev/null && echo "running (PID $pid)" || echo "dead (stale PID $pid)"
}

stop_service() {
  local pf; pf=$(pid_file "$1")
  if [ ! -f "$pf" ]; then echo "[$1] no PID file"; return; fi
  local pid; pid=$(cat "$pf")
  if kill -0 "$pid" 2>/dev/null; then
    kill "$pid" && echo "[$1] stopped (PID $pid)"
  else
    echo "[$1] was not running"
  fi
  rm -f "$pf"
}

start_service() {
  local log; log=$(log_file "$1")
  if [ "$1" = "backend" ]; then
    echo "[backend] :${BACKEND_PORT:-3001}  log → $log"
    cd "$ROOT/backend" && node index.js >> "$log" 2>&1 &
  else
    echo "[frontend] :${FRONTEND_PORT:-5173}  log → $log"
    cd "$ROOT/frontend" && npm run dev >> "$log" 2>&1 &
  fi
  echo $! > "$(pid_file "$1")"
  echo "[$1] started PID $!"
}

services() {
  [ "$TARGET" = "all" ] && echo "backend frontend" || echo "$TARGET"
}

echo "[app-ctl] branch=$BRANCH  backend=:${BACKEND_PORT:-3001}  frontend=:${FRONTEND_PORT:-5173}"

case "$CMD" in
  status)
    for svc in $(services); do echo "[$svc] $(is_alive "$svc")"; done ;;
  start)
    for svc in $(services); do start_service "$svc"; done ;;
  stop)
    for svc in $(services); do stop_service "$svc"; done ;;
  restart)
    for svc in $(services); do stop_service "$svc"; done
    sleep 1
    for svc in $(services); do start_service "$svc"; done ;;
  *)
    echo "Usage: $0 <status|start|stop|restart> [backend|frontend|all]"
    exit 1 ;;
esac
