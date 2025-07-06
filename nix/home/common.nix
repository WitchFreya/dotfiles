{ ... }:
{
  imports = [
    ./shell.nix
    ./git.nix
    ./nix-direnv.nix
  ];
  home = {
    username = "witch";
    stateVersion = "25.11";
  };
}
