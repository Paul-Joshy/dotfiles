#!/bin/bash
set -euo pipefail

SKYLAND="$HOME/.local/bin/skyland"
STATE_DIR="$HOME/.cache/skyland/layout-mode"
MODE="${1:?usage: set-workspace-layout.sh master|floating}"
WORKSPACE="$($SKYLAND list-workspaces --focused)"
WINDOWS="$($SKYLAND list-windows --workspace "$WORKSPACE" --format '%{window-id}|%{window-layout}')"
SAFE_WORKSPACE="$(printf '%s' "$WORKSPACE" | /usr/bin/sed 's/[^A-Za-z0-9_.-]/_/g')"
STATE_FILE="$STATE_DIR/$SAFE_WORKSPACE"

mkdir -p "$STATE_DIR"

case "$MODE" in
    floating)
        printf 'floating\n' > "$STATE_FILE"
        "$SKYLAND" master off
        if [[ -n "$WINDOWS" ]]; then
            while IFS='|' read -r window_id _layout; do
                [[ -n "$window_id" ]] || continue
                "$SKYLAND" layout --window-id "$window_id" floating || true
            done <<< "$WINDOWS"
        fi
        ;;
    master)
        rm -f "$STATE_FILE"
        if [[ -n "$WINDOWS" ]]; then
            while IFS='|' read -r window_id _layout; do
                [[ -n "$window_id" ]] || continue
                "$SKYLAND" layout --window-id "$window_id" tiling || true
            done <<< "$WINDOWS"
        fi
        "$SKYLAND" master on
        ;;
    *)
        echo "usage: set-workspace-layout.sh master|floating" >&2
        exit 2
        ;;
esac
