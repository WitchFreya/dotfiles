{ ... }:
{
  # Claude Code runs each command in a fresh non-interactive `zsh -c` (sources
  # .zshenv, sets CLAUDECODE), where nix-direnv's interactive hook never fires.
  programs.zsh.envExtra = ''
    if [[ -n "$CLAUDECODE" ]]; then
      eval "$(direnv export zsh 2>/dev/null)"
    fi
  '';

  home.file.".claude/CLAUDE.md".source = ./claude-code.md;
}