# unfortunately required for work
{ pkgs, ... }:
{
  environment.systemPackages = [ pkgs.claude-code ];
  homebrew.casks = [
    "claude"
  ];
}
