#!/usr/bin/env bash
shopt -s nullglob

git_dir=$(git -C "$CLAUDE_PROJECT_DIR" rev-parse --path-format=absolute --git-common-dir 2>/dev/null)
project=${git_dir%/.git}
project=${project:-$CLAUDE_PROJECT_DIR}
memory="$HOME/.claude/projects/${project//[^[:alnum:]]/-}/memory"
today=$(date +%F)

for file in "$memory"/*.md; do
  stale_after=$(grep -m1 '^ *stale-after:' "$file" | grep -oE '[0-9]{4}-[0-9]{2}-[0-9]{2}')
  if [[ -n $stale_after && $stale_after < $today ]]; then
    echo "Memory past its stale-after ($stale_after): $(basename "$file"). Archive it per the MEMORY.md conventions, keeping anything still durable in a successor."
  fi
done
