{ self, ... }:
{
  imports = [
    ../common/homebrew.nix
  ];
  networking.hostName = "1x1-osx";
  nixpkgs.overlays = [ self.inputs.nix4vscode.overlays.forVscode ];
  system.primaryUser = "witch";
  system.stateVersion = 6;
  # allow sudo auth with touch id
  security.pam.services.sudo_local.touchIdAuth = true;
  # necessary to get home-manager to behave.
  users.users.witch.home = /Users/witch;

  nix.gc.interval = {
    Weekday = 7;
    Hour = 0;
    Minute = 0;
  };

  # To set to light mode, set this to null and you’ll need to manually run defaults delete -g AppleInterfaceStyle.
  system.defaults.NSGlobalDomain.AppleInterfaceStyle = "Dark";
}
