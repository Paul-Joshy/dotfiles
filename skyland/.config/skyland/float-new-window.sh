#!/bin/bash
set -euo pipefail

SKYLAND="$HOME/.local/bin/skyland"
STATE_DIR="$HOME/.cache/skyland/layout-mode"
WINDOW_ID="${AEROSPACE_WINDOW_ID:-}"
[[ -n "$WINDOW_ID" ]] || exit 0

WINDOWS="$($SKYLAND list-windows --all --format '%{window-id}|%{workspace}')"
WORKSPACE="$(printf '%s\n' "$WINDOWS" | /usr/bin/awk -F'|' -v id="$WINDOW_ID" '$1 == id { print $2; exit }')"
[[ -n "$WORKSPACE" ]] || exit 0
SAFE_WORKSPACE="$(printf '%s' "$WORKSPACE" | /usr/bin/sed 's/[^A-Za-z0-9_.-]/_/g')"
[[ -f "$STATE_DIR/$SAFE_WORKSPACE" ]] || exit 0

exec "$SKYLAND" layout --window-id "$WINDOW_ID" floating
