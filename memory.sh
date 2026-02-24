#!/bin/bash

CMDS=("node ssr/local-server-prod.js" "node .output/server/index.mjs" "node server.js" "bun ssr/local-server-prod.js")
IGNORE_PID="$1"
REFRESH_INTERVAL=3

find_pid() {
  PIDS=""
  for CMD in "${CMDS[@]}"; do
    PIDS="$PIDS
$(pgrep -f "$CMD")"
  done
  PIDS=$(echo "$PIDS" | sed '/^$/d')
  # Filter out processes whose command line contains "Documents" (e.g. this script itself)
  PIDS=$(echo "$PIDS" | while read -r p; do
    ps -o args= -p "$p" 2>/dev/null | grep -q "Documents" || echo "$p"
  done)
  if [ -n "$IGNORE_PID" ]; then
    PIDS=$(echo "$PIDS" | grep -v "^${IGNORE_PID}$")
  fi
  echo "$PIDS" | head -n 1
}

CURRENT_PID=""
TICK=0

while true; do
  # Re-detect PID every REFRESH_INTERVAL seconds or if current process is gone
  if [ -z "$CURRENT_PID" ] || [ "$TICK" -ge "$REFRESH_INTERVAL" ] || ! kill -0 "$CURRENT_PID" 2>/dev/null; then
    NEW_PID=$(find_pid)
    if [ -n "$NEW_PID" ] && [ "$NEW_PID" != "$CURRENT_PID" ]; then
      echo "# Monitoring PID: $NEW_PID" >&2
      CURRENT_PID="$NEW_PID"
    fi
    TICK=0
  fi

  if [ -n "$CURRENT_PID" ] && kill -0 "$CURRENT_PID" 2>/dev/null; then
    ps -o rss= -p "$CURRENT_PID" | awk '{print $1/1024}'
  else
    echo 0
  fi

  sleep 1
  TICK=$((TICK + 1))
done | ttyplot -u Mi

