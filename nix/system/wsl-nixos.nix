{ pkgs, ... }:
{
  imports = [
    ./openssh.nix
    ./configuration.nix
  ];
  system.stateVersion = "24.11";
  wsl.enable = true;
  wsl.defaultUser = "witch";
  programs.nix-ld.enable = true;
  documentation.dev.enable = true;
  users.defaultUserShell = pkgs.zsh;
  users.users.witch.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFPmZTMA6pUYhm8RxKRF6x7QMVGcueMnTrdOn1btnkRd"
  ];
  systemd.services.sshd.wantedBy = pkgs.lib.mkForce [ "multi-user.target" ];
}
