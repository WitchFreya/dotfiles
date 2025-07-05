{ ... }:
{
  imports = [
    ./shell.nix
    ./git.nix
  ];
  home = {
    username = "witch";
    stateVersion = "25.11";
  };
}
