{ pkgs, lib, ... }:
{
  networking.hostName = "folkvangr";
  system.stateVersion = "24.11";
  wsl.enable = true;
  wsl.defaultUser = "witch";
  programs.nix-ld.enable = true;
  documentation.dev.enable = true;
  users.defaultUserShell = pkgs.zsh;
  nix.gc.dates = "2w";
  systemd.services.sshd.wantedBy = pkgs.lib.mkForce [ "multi-user.target" ];
  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
    settings.KbdInteractiveAuthentication = false;
    settings.PermitRootLogin = lib.mkDefault "no";
  };
  users.users.witch.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFPmZTMA6pUYhm8RxKRF6x7QMVGcueMnTrdOn1btnkRd"
  ];
}
