#!/usr/bin/env bash
# Shared port allocation based on branch name.
# Source this file; call: resolve_ports <branch>
# Sets: BACKEND_PORT, FRONTEND_PORT, API_URL

# Port map: branch-name -> backend-port frontend-port
# Add new worktrees here as you create them.
declare -A BRANCH_PORTS=(
  ["main"]="3001 5173"
  ["feature/filters"]="3002 5174"
  ["feature/due-dates"]="3003 5175"
  ["feature/priority"]="3004 5176"
)

resolve_ports() {
  local branch="$1"
  local mapping="${BRANCH_PORTS[$branch]}"

  if [ -z "$mapping" ]; then
    # Unknown branch: derive ports from a hash of the branch name so they
    # don't collide with the reserved slots above (range 3100-3199 / 5200-5299).
    local hash
    hash=$(echo -n "$branch" | cksum | awk '{print $1 % 100}')
    BACKEND_PORT=$((3100 + hash))
    FRONTEND_PORT=$((5200 + hash))
  else
    BACKEND_PORT=$(echo "$mapping" | awk '{print $1}')
    FRONTEND_PORT=$(echo "$mapping" | awk '{print $2}')
  fi

  API_URL="http://localhost:${BACKEND_PORT}"
}
