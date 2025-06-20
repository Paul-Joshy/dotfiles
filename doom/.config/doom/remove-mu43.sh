#!/usr/bin/env bash
set -e

CONFIG_DIR="$HOME/.config/doom"
FILES=("init.el" "config.el" "custom.el")

echo "🔍 Commenting out mu4e-related lines in Doom Emacs config..."

for file in "${FILES[@]}"; do
  filepath="$CONFIG_DIR/$file"
  if [[ -f "$filepath" ]]; then
    sed -i.bak '/mu4e/ s/^/;; /' "$filepath"
    echo "✅ Edited $filepath"
  fi
done

echo "🔄 Running doom sync..."
"$HOME/.emacs.d/bin/doom" sync

echo "✅ Done. You can now restart Emacs without mu4e errors."

