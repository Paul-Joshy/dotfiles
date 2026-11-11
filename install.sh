#!/bin/sh
# install.sh: link dotfiles packages into $HOME with GNU Stow.
#
#   ./install.sh                 dry run for every package
#   ./install.sh --apply         link every package
#   ./install.sh --apply nvim    link only the packages you name
#
# Stow refuses to overwrite real files, so an existing config is never lost:
# move it aside first (see docs/how-to.md).

set -eu

cd "$(dirname "$0")"

command -v stow >/dev/null 2>&1 || {
	echo "GNU Stow is required: brew install stow (macOS) or pacman -S stow (Arch)" >&2
	exit 1
}

mode="-n"
if [ "${1:-}" = "--apply" ]; then
	mode=""
	shift
fi

if [ "$#" -gt 0 ]; then
	packages="$*"
else
	packages=$(find . -mindepth 1 -maxdepth 1 -type d \
		! -name '.git' ! -name 'docs' ! -name 'legacy-2018' \
		-exec basename {} \; | sort)
fi

[ -n "$mode" ] && echo "Dry run. Nothing will change. Re-run with --apply to link."

for pkg in $packages; do
	echo "== $pkg"
	stow $mode -v -t "$HOME" "$pkg"
done
