{ lib, ... }:
{
  imports = [
    ../modules/git.nix
    ./shell.nix
    ./nix-direnv.nix
  ];
  home = {
    username = "witch";
    stateVersion = "25.11";
  };
  programs.git = {
    signing.key = lib.mkDefault "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFPmZTMA6pUYhm8RxKRF6x7QMVGcueMnTrdOn1btnkRd";
    userEmail = lib.mkDefault "freya@webwitch.org";
  };
}
