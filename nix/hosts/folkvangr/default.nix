{ pkgs, lib, ... }:
{
  networking.hostName = "folkvangr";
  system.stateVersion = "24.11";
  wsl.enable = true;
  wsl.defaultUser = "witch";
  wsl.useWindowsDriver = true;

  hardware.nvidia-container-toolkit = {
    enable = true;
    mount-nvidia-executables = false; # https://github.com/nix-community/NixOS-WSL/issues/578
    suppressNvidiaDriverAssertion = true;
  };

  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
    autoPrune.enable = true;
  };

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
  environment.sessionVariables.LD_LIBRARY_PATH = [ "/run/opengl-driver/lib/" ];
  environment.sessionVariables.GALLIUM_DRIVER = "d3d12";
}
