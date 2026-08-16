#!/usr/bin/env bash
# Prints "branch*" (dirty) or "branch" for the git repo at $1 (pane cwd).
# Empty output if $1 isn't inside a git repo.
dir="${1:-.}"
branch=$(git -C "$dir" branch --show-current 2>/dev/null)
[[ -z "$branch" ]] && exit 0

if ! git -C "$dir" diff --quiet 2>/dev/null || ! git -C "$dir" diff --cached --quiet 2>/dev/null; then
    dirty='*'
else
    dirty=''
fi

printf '%s%s' "$branch" "$dirty"
