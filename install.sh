#!/usr/bin/env sh
# Link this repo into the skill directories of Claude Code and Cursor.
# Symlinks, so `git pull` here updates both.
#
#   ./install.sh            # link into ~/.claude/skills and ~/.cursor/skills
#   ./install.sh --uninstall
set -eu

here="$(cd "$(dirname "$0")" && pwd)"
name="blueprint"
targets="$HOME/.claude/skills $HOME/.cursor/skills"

if [ "${1:-}" = "--uninstall" ]; then
  for dir in $targets; do
    link="$dir/$name"
    if [ -L "$link" ]; then rm "$link"; echo "removed $link"; fi
  done
  exit 0
fi

for dir in $targets; do
  mkdir -p "$dir"
  link="$dir/$name"
  if [ -L "$link" ]; then
    rm "$link"
  elif [ -e "$link" ]; then
    echo "skip: $link exists and is not a symlink (remove it to install)"; continue
  fi
  ln -s "$here" "$link"
  echo "linked $link -> $here"
done

mkdir -p "$HOME/.blueprint"
echo "plans will be written to ~/.blueprint/"
