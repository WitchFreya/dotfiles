{
  description = "Nix configurations";

  inputs = {
    # nix-darwin
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    mac-app-util.url = "github:hraban/mac-app-util";
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.93.3-1.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # wsl
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";

    # Shared
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix4vscode = {
      url = "github:nix-community/nix4vscode";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      nix-darwin,
      nixos-wsl,
      home-manager,
      mac-app-util,
      flake-utils,
      lix-module,
      nix-homebrew,
      ...
    }:
    let
      darwinSystem =
        primaryUser: hostName:
        nix-darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          specialArgs = { inherit self; };
          modules = [
            nix-homebrew.darwinModules.nix-homebrew
            home-manager.darwinModules.home-manager
            mac-app-util.darwinModules.default
            lix-module.nixosModules.default
            ./nix/system/nix-darwin
            {
              home-manager.sharedModules = [
                mac-app-util.homeManagerModules.default
              ];
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              networking.hostName = hostName;
              home-manager.users."${primaryUser}" = import ./nix/home/${hostName}.nix;
            }
          ];
        };
    in
    {
      darwinConfigurations."1x1-osx" = darwinSystem "witch" "1x1-osx";

      darwinConfigurations.summer-osx = darwinSystem "witch" "summer-osx";

      nixosConfigurations = {
        Folkvangr = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            nixos-wsl.nixosModules.default
            home-manager.nixosModules.home-manager
            ./nix/system/wsl-nixos.nix
            {
              networking.hostName = "Folkvangr";
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.witch = import ./nix/home/folkvangr.nix;
            }
          ];
        };

        liveIso = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            home-manager.nixosModules.home-manager
            ./nix/system/live-iso.nix
          ];
        };
      };

      devShells = flake-utils.lib.eachDefaultSystemPassThrough (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          ${system}.default = pkgs.mkShell {
            packages = with pkgs; [
              nixfmt-rfc-style
              nixd
            ];
          };
        }
      );
    };
}
