#!/usr/bin/env bash
cmd=$(jq -r .tool_input.command | tr '\n' ' ')
unquoted=$(sed -E -e 's/"[^"]*"//g' -e "s/'[^']*'//g" <<<"$cmd")

if [[ $unquoted == *"gh pr create"* && $unquoted != *--draft* ]]; then
  echo "gh pr create needs --draft: PRs open as drafts, marking ready is Freya's call." >&2
  exit 2
fi

if grep -qE 'git (-C [^ ]+ )?commit.* -[a-z]*n' <<<"$unquoted"; then
  echo "git commit -n skips the commit hooks; commit without it." >&2
  exit 2
fi
