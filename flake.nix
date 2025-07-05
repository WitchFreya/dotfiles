{
  description = "Nix configurations";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      nix-darwin,
      nixpkgs,
      nixos-wsl,
      home-manager,
      ...
    }:
    {
      homeConfigurations = {
        "witch@Folkvangr" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          modules = [
            ./nix/home/common.nix
            ./nix/home/folkvangr.nix
          ];
        };

        "witch@1x1-osx" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.aarch64-darwin;
          modules = [
            ./nix/home/common.nix
            ./nix/home/1x1-osx.nix
          ];
        };
      };
      darwinConfigurations."1x1-osx" = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          ./nix/system/1x1-osx.nix
        ];
      };

      nixosConfigurations.Folkvangr = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          nixos-wsl.nixosModules.default
          ./nix/system/folkvangr.nix
        ];
      };
    };
}
