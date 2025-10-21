{ ... }:
{
  imports = [
    ./configuration.nix
  ];
  wsl.enable = true;
  wsl.defaultUser = "witch";
  networking.hostName = "Folkvangr";
  programs.nix-ld.enable = true;
  documentation.dev.enable = true;
}
