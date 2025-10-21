{ pkgs, ... }:
{
  # integrate the shell plugin
  programs._1password-shell-plugins.plugins = [ pkgs.awscli2 ];

  # enable the cli
  programs.awscli.enable = true;

  # the CLI plugin will fail without this.
  programs.awscli.settings.default = { };
}
