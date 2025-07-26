{ ... }:
{
  imports = [
    ./configuration.nix
  ];
  system.primaryUser = "witch";
  system.stateVersion = 6;
  security.pam.services.sudo_local.touchIdAuth = true;
  nix.linux-builder.enable = true;

  users.users.witch = {
    home = "/Users/witch";
  };

  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
      upgrade = true;
    };
  };
}
