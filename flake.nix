{
  description = "Nix configurations";

  inputs = {
    # nix-darwin
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    mac-app-util.url = "github:hraban/mac-app-util";

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
      ...
    }:
    {
      darwinConfigurations."1x1-osx" = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        specialArgs = { inherit self; };
        modules = [
          home-manager.darwinModules.home-manager
          mac-app-util.darwinModules.default
          ./nix/hosts/common
          ./nix/hosts/1x1-osx
        ];
      };

      darwinConfigurations.summer-osx = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        specialArgs = { inherit self; };
        modules = [
          home-manager.darwinModules.home-manager
          mac-app-util.darwinModules.default
          ./nix/hosts/common
          ./nix/hosts/summer-osx
        ];
      };

      nixosConfigurations = {
        Folkvangr = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            nixos-wsl.nixosModules.default
            home-manager.nixosModules.home-manager
            ./nix/hosts/common
            ./nix/hosts/folkvangr
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
