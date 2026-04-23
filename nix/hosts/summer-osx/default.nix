{ self, pkgs, ... }:
let
  primaryUser = "witch";
in
{
  imports = [
    ../common/homebrew.nix
  ];
  networking.hostName = "summer-osx";
  nixpkgs.overlays = [ self.inputs.nix4vscode.overlays.forVscode ];
  system.primaryUser = primaryUser;
  system.stateVersion = 6;
  # allow sudo auth with touch id
  security.pam.services.sudo_local.touchIdAuth = true;
  # necessary to get home-manager to behave.
  users.users.${primaryUser}.home = /Users/${primaryUser};

  nix.gc.interval = {
    Weekday = 7;
    Hour = 0;
    Minute = 0;
  };

  # To set to light mode, set this to null and you’ll need to manually run defaults delete -g AppleInterfaceStyle.
  system.defaults.NSGlobalDomain.AppleInterfaceStyle = "Dark";

  environment.systemPackages = with pkgs; [
    heroku
    netlify-cli
    postgresql_17
  ];

  homebrew.casks = [
    "dbeaver-community"
  ];

  services.onepassword-secrets = {
    enable = true;
    groupId = 601;
    users = [ primaryUser ];
    secrets = {
      githubPackagesPAT = {
        reference = "op://Work Secrets/GitHub Packages PAT/credential";
        path = "/Users/${primaryUser}/.config/github.pat";
        owner = primaryUser;
        mode = "0600";
      };
    };
  };
}
