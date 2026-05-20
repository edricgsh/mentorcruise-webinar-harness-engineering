#!/usr/bin/env bash
# Control script for todo app processes
# Usage: scripts/app-ctl.sh <status|stop|restart> [backend|frontend|all]

set -e

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
BRANCH=$(git -C "$ROOT" rev-parse --abbrev-ref HEAD 2>/dev/null || echo "nobranch")

TARGET="${2:-all}"

pid_file() {
  echo "/tmp/todo-${1}.pid"
}

log_file() {
  echo "/tmp/todo-${BRANCH}-${1}.log"
}

is_alive() {
  local PID_FILE
  PID_FILE=$(pid_file "$1")
  if [ -f "$PID_FILE" ]; then
    local PID
    PID=$(cat "$PID_FILE")
    kill -0 "$PID" 2>/dev/null && echo "running (PID $PID)" || echo "dead (stale PID $PID)"
  else
    echo "not started"
  fi
}

stop_service() {
  local PID_FILE
  PID_FILE=$(pid_file "$1")
  if [ -f "$PID_FILE" ]; then
    local PID
    PID=$(cat "$PID_FILE")
    if kill -0 "$PID" 2>/dev/null; then
      kill "$PID" && echo "[$1] stopped (PID $PID)"
    else
      echo "[$1] was not running"
    fi
    rm -f "$PID_FILE"
  else
    echo "[$1] no PID file found"
  fi
}

start_service() {
  local LOG
  LOG=$(log_file "$1")
  echo "[$1] log → $LOG"
  if [ "$1" = "backend" ]; then
    cd "$ROOT/backend" && node index.js >> "$LOG" 2>&1 &
  else
    cd "$ROOT/frontend" && npm run dev >> "$LOG" 2>&1 &
  fi
  echo $! > "$(pid_file "$1")"
  echo "[$1] started (PID $!)"
}

services() {
  [ "$TARGET" = "all" ] && echo "backend frontend" || echo "$TARGET"
}

case "${1}" in
  status)
    for svc in $(services); do
      echo "[$svc] $(is_alive "$svc")"
    done
    ;;
  stop)
    for svc in $(services); do
      stop_service "$svc"
    done
    ;;
  restart)
    for svc in $(services); do
      stop_service "$svc"
      sleep 1
      start_service "$svc"
    done
    ;;
  start)
    for svc in $(services); do
      start_service "$svc"
    done
    ;;
  *)
    echo "Usage: $0 <status|start|stop|restart> [backend|frontend|all]"
    exit 1
    ;;
esac
