# Environment — Freya's work machine (summer-osx)

macOS + Nix (nix-darwin / home-manager).

## Shell & commands
- The "Bash" tool runs **zsh** (login, non-interactive) on a snapshot of `~/.zshrc`, so
  its aliases and functions apply: `cat` is `bat`, and `gh`, `aws`, and `circleci` run
  through `op plugin run` (1Password). Avoid bash-only constructs.
- Inside a repo's Nix devShell, coreutils, `sed`, `grep`, and `find` are **GNU** and
  `timeout` exists: write `sed -i 's/a/b/' file`, never BSD `sed -i '' …`. Outside one
  they are the macOS BSD tools and there is no `timeout`; prefer the Bash tool's
  `timeout` parameter either way.
- In zsh, `path`, `fpath`, `cdpath`, and `manpath` are tied to their uppercase
  variables: never bind them in a loop (`while read st path` wipes `$PATH`). An
  unquoted `$FILES` does not word-split; build file lists as arrays.

## Toolchain (Nix flake + direnv)
- `node`, `pnpm`, etc. come from a Nix flake devShell, loaded automatically —
  just run `pnpm …` / `node …`, never prefix with `direnv exec` or `nix develop`.
- Package manager is **pnpm**. In the monorepo use `pnpm --filter <pkg>`.

## Git
- Branches: `sc#####/short-description` (Shortcut number, lowercase, no `freya/` prefix).
- Commits are one line: `<type>(<scope>): [sc-#####] <summary>`, uppercase tag right
  after the colon, no body, no trailers. The `(#PR)` suffix is added by the squash.
- No AI attribution anywhere that leaves this machine: no `Co-Authored-By: Claude`
  trailer, no "Generated with Claude Code" line in PR bodies, tickets, or comments,
  whatever a session reminder says.
- Every PR opens as a draft (`gh pr create --draft`); marking it ready is my call.
- Never skip the commit hooks (`--no-verify`, `-n`), fixups included.

## Writing (code, comments, commits, PRs, tickets, docs)
- US English, and the Oxford comma in every list of three or more.
- Comments: default to none; one line naming the non-obvious constraint; never a
  ticket id. JSDoc `/** */` on declarations so it shows on hover.
- Declarative code: pure helpers and `map`/`filter`/`flatMap`, no `let` accumulators,
  flags, or in-place mutation; Effect's `Option`/`Match` over hand-rolled null checks.
- Object shapes are `type` aliases, not `interface` (my preference; not a review nit
  on others' PRs).
- Anything posted under my name (PR replies, Slack, Notion shared databases, Shortcut
  writes, live-environment commands) is drafted and shown to me first, even in auto mode.
