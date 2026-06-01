{ pkgs, ... }:
{
  # Work requires some additional extensions.
  programs.vscodium.profiles.default.extensions = pkgs.nix4vscode.forVscode [
    "anthropic.claude-code"
    "snyk-security.snyk-vulnerability-scanner"
  ];
}
