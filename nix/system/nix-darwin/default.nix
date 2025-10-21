{ lib, self, ... }:
{
  imports = [
    ../shared.nix
    ./homebrew.nix
  ];
  nixpkgs.overlays = [ self.inputs.nix4vscode.overlays.forVscode ];
  system.primaryUser = "witch";
  system.stateVersion = 6;
  # allow sudo auth with touch id
  security.pam.services.sudo_local.touchIdAuth = true;

  users.users.witch = {
    home = "/Users/witch";
  };

  programs.ssh.extraConfig = lib.strings.readFile ../../../ssh/witch_1x1-osx.config;
  nix.gc.interval = {
    Weekday = 7;
    Hour = 0;
    Minute = 0;
  };

  system.defaults.NSGlobalDomain.AppleInterfaceStyle = "Dark";
}
