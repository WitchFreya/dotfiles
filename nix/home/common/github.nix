{ pkgs, ... }:
{
  programs.gh = {
    enable = true;
    settings.git_protocol = "ssh";
  };
  programs._1password-shell-plugins.plugins = [ pkgs.gh ];
}
