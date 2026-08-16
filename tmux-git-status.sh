#!/usr/bin/env bash
# Prints "repo:branch*" (dirty) or "repo:branch" for the git repo at $1 (pane cwd).
# Empty output if $1 isn't inside a git repo.
dir="${1:-.}"
branch=$(git -C "$dir" branch --show-current 2>/dev/null)
[[ -z "$branch" ]] && exit 0

toplevel=$(git -C "$dir" rev-parse --show-toplevel 2>/dev/null)
repo=$(basename "$toplevel")

if ! git -C "$dir" diff --quiet 2>/dev/null || ! git -C "$dir" diff --cached --quiet 2>/dev/null; then
    dirty='*'
else
    dirty=''
fi

printf '%s:%s%s' "$repo" "$branch" "$dirty"
