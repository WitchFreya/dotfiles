{ ... }:

{
  imports = [
    ./configuration.nix
  ];
  system.primaryUser = "witch";
  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 6;

  # handled by determinate
  nix.enable = false;

  security.pam.services.sudo_local.touchIdAuth = true;
}