# Root configuration for all systems.
{
  pkgs,
  config,
  self,
  ...
}:
{
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = "nix-command flakes";
  environment.systemPackages = with pkgs; [
    wget
    vim
    git
    gh
    bat
    man-pages
    man-pages-posix
    home-manager
    nixfmt-rfc-style
    nixd
    direnv
  ];
  fonts.packages = with pkgs; [ nerd-fonts.fira-code ];
  environment.pathsToLink = [ "/share/zsh" ];
  programs.zsh.enable = true;
  time.timeZone = "America/Los_Angeles";

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users."${config.system.primaryUser}" =
    import ../../home/${config.networking.hostName}.nix;
  home-manager.sharedModules =
    if pkgs.stdenv.isDarwin then
      [
        self.inputs.mac-app-util.homeManagerModules.default
      ]
    else
      [ ];

  nix.gc = {
    automatic = true;
    options = "--delete-older-than 14d";
  };
}
