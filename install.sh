#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
echo "==> Installing dotfiles from $DOTFILES_DIR"

# List of folders to ignore (non-Stow packages)
IGNORED_PACKAGES=("install-scripts" "apt" "arc-theme-apt-files" "snaps" "npm" "ruby_gems")

# 🔧 Remove non-symlink conflicting files before stowing
clean_conflicts() {
  local pkg="$1"
  echo "   🧹 Checking for conflicts in '$pkg'..."

  stow --dir="$DOTFILES_DIR" --target="$HOME" --no --verbose "$pkg" 2>&1 |
    grep "LINK:" |
    awk '{print $2}' |
    while read -r target; do
      if [ -e "$target" ] && [ ! -L "$target" ]; then
        echo "   ⚠️  Removing conflicting file: $target"
        rm -rf "$target"
      fi
    done
}

# 📦 Stow a single package cleanly
stow_package() {
  local pkg="$1"
  clean_conflicts "$pkg"
  echo " → Stowing '$pkg'"
  stow --dir="$DOTFILES_DIR" --target="$HOME" "$pkg"
}

# 🔁 Loop over top-level directories in dotfiles
for pkg_path in "$DOTFILES_DIR"/*/; do
  pkg="$(basename "$pkg_path")"

  # Skip ignored items
  if [[ " ${IGNORED_PACKAGES[*]} " == *" $pkg "* ]]; then
    continue
  fi

  [ -d "$DOTFILES_DIR/$pkg" ] || continue
  stow_package "$pkg"
done

echo "✅ Dotfiles installed successfully!"

