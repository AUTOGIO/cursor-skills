#!/bin/zsh
# List Apple Shortcuts for the apple-shortcuts skill (read-only).
set -euo pipefail

SHORTCUTS_BIN="/usr/bin/shortcuts"

if [[ ! -x "$SHORTCUTS_BIN" ]]; then
  echo "error: shortcuts CLI not found at $SHORTCUTS_BIN" >&2
  exit 1
fi

json=0
if [[ "${1:-}" == "--json" ]]; then
  json=1
fi

# Capture names (one per line). Fail clearly if CLI errors.
if ! names="$("$SHORTCUTS_BIN" list 2>/dev/null)"; then
  echo "error: shortcuts list failed (permissions or Shortcuts unavailable)" >&2
  exit 1
fi

count="$(print -r -- "$names" | grep -c . || true)"

if (( json )); then
  # Minimal JSON array; escape backslash and double-quote.
  print -n '['
  first=1
  print -r -- "$names" | while IFS= read -r line; do
    [[ -z "$line" ]] && continue
    esc="${line//\\/\\\\}"
    esc="${esc//\"/\\\"}"
    if (( first )); then
      first=0
    else
      print -n ','
    fi
    print -n "\"$esc\""
  done
  print ']'
  exit 0
fi

print -r -- "# Apple Shortcuts inventory"
print -r -- "# host: $(scutil --get ComputerName 2>/dev/null || hostname)"
print -r -- "# generated: $(date '+%Y-%m-%d_%H-%M-%S')"
print -r -- "# count: $count"
print -r -- "#"
print -r -- "$names" | sort
