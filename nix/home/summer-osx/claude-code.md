# Environment — Freya's work machine (summer-osx)

macOS + Nix (nix-darwin / home-manager).

## Shell & commands
- The "Bash" tool runs **zsh**, not bash. Avoid bash-only constructs.
- **No GNU coreutils.** `timeout` / `gtimeout` are NOT installed — use the Bash
  tool's `timeout` parameter or `run_in_background` + polling instead.

## Toolchain (Nix flake + direnv)
- `node`, `pnpm`, etc. come from a Nix flake devShell, loaded automatically —
  just run `pnpm …` / `node …`, never prefix with `direnv exec` or `nix develop`.
- Package manager is **pnpm**. In the monorepo use `pnpm --filter <pkg>`.

## Git
- Branches: `sc#####/short-description` (Shortcut number, lowercase, no `freya/` prefix).
