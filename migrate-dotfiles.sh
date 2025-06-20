#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$DOTFILES_DIR"

echo "🔁 Migrating dotfiles to Stow-friendly structure..."

# 1. Restructure config folders
for name in doom i3 polybar mpv nvim nvm ranger zathura dunst; do
  if [ -d "$name" ]; then
    echo "📁 Restructuring $name"
    mkdir -p "$name/.config/$name"
    shopt -s dotglob
    mv "$name"/* "$name/.config/$name/" 2>/dev/null || true
    shopt -u dotglob
  fi
done

# 2. Move VS Code config
if [ -d Code ]; then
  echo "📁 Moving VS Code config"
  mkdir -p vscode/.config/Code
  mv Code vscode/.config/Code/
fi

# 3. Move home dotfiles into separate packages
if [ -d home ]; then
  echo "🏠 Extracting home dotfiles"
  for file in home/.*; do
    [ -f "$file" ] || continue
    base="$(basename "$file")"
    case "$base" in
      .zshrc) pkg="zsh" ;;
      .gitconfig) pkg="git" ;;
      .tmux.conf) pkg="tmux" ;;
      *) echo "⚠️  Unknown dotfile: $file" && continue ;;
    esac
    echo "   → Moving $base to $pkg/"
    mkdir -p "$pkg"
    mv "$file" "$pkg/"
  done
  rm -rf home
fi

# 4. Move scripts into bin/
if [ -d scripts ]; then
  echo "🔧 Moving scripts into bin/"
  mkdir -p bin
  mv scripts/* bin/
  rm -rf scripts
fi

echo "✅ Migration complete. Ready to stow!"

