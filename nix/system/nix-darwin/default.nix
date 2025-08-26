{ lib, self, ... }:
{
  imports = [
    ../shared.nix
  ];
  nixpkgs.overlays = [ self.inputs.nix4vscode.overlays.forVscode ];
  system.primaryUser = "witch";
  system.stateVersion = 6;
  # allow sudo auth with touch id
  security.pam.services.sudo_local.touchIdAuth = true;

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
    casks = [
      "firefox"
      "bettertouchtool"
      "1password"
      "todoist-app"
    ];
  };
  programs.ssh.extraConfig = lib.strings.readFile ../../../ssh/witch_1x1-osx.config;
}
