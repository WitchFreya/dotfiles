{
  pkgs,
  lib,
  modulesPath,
  ...
}:
{
  imports = [
    (modulesPath + "/installer/cd-dvd/installation-cd-graphical-gnome.nix")
    ./openssh.nix
    ./configuration.nix
  ];
  environment.systemPackages = with pkgs; [ neovim ];
  isoImage.squashfsCompression = "gzip -Xcompression-level 1";
  networking.hostName = "liveIso";
  time.timeZone = "America/Los_Angeles";
  nixpkgs = {
    hostPlatform = lib.mkDefault "x86_64-linux";
    config.allowUnfree = true;
  };

  services = {
    qemuGuest.enable = true;
    openssh = {
      enable = true;
      settings.PasswordAuthentication = false;
      settings.KbdInteractiveAuthentication = false;
      settings.PermitRootLogin = lib.mkForce "yes";
    };
  };

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    supportedFilesystems = lib.mkForce [
      "btrfs"
      "reiserfs"
      "vfat"
      "f2fs"
      "xfs"
      "ntfs"
      "cifs"
    ];
  };

  users = {
    mutableUsers = false;
    users.witch = {
      group = "witch";
      isNormalUser = true;
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFPmZTMA6pUYhm8RxKRF6x7QMVGcueMnTrdOn1btnkRd"
      ];
    };
    groups.witch = { };
  };

  systemd = {
    services.sshd.wantedBy = pkgs.lib.mkForce [ "multi-user.target" ];
    targets = {
      sleep.enable = false;
      suspend.enable = false;
      hibernate.enable = false;
      hybrid-sleep.enable = false;
    };
  };

  networking.networkmanager = {
    enable = true;
  };
}
