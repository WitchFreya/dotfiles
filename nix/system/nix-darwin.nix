{ lib, ... }:
{
  imports = [
    ./configuration.nix
  ];
  system.primaryUser = "witch";
  system.stateVersion = 6;
  # allow sudo auth with touch id
  security.pam.services.sudo_local.touchIdAuth = true;
  nix.linux-builder = {
    enable = true;
    systems = [
      "aarch64-linux"
      "x86_64-linux"
    ];
    ephemeral = true;
    config.boot.binfmt.emulatedSystems = [ "x86_64-linux" ];
  };

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
  programs.ssh.extraConfig = lib.strings.readFile ../../ssh/witch_1x1-osx.config;
}
