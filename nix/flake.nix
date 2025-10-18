################
## MAIN FLAKE ##
################

{
  description = "NixOS Configuration";

  inputs = {
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    catppuccin.url = "github:catppuccin/nix";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  outputs =
    inputs@{
      nixpkgs-stable,
      nixpkgs-unstable,
      catppuccin,
      home-manager,
      ...
    }:
    {
      nixosConfigurations.brad-nixos-macbook = nixpkgs-unstable.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          catppuccin.nixosModules.catppuccin

          ./hosts/macbook/configuration.nix

          # make home-manager as a module of nixos
          # so that home-manager configuration will be deployed automatically when executing `nixos-rebuild switch`
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.users.brad = {
              imports = [
                ./nixModules/home.nix
                catppuccin.homeModules.catppuccin
              ];
            };
          }
        ];
      };

      nixosConfigurations.pheg-nixos-desktop = inputs.nixpkgs-stable.lib.nixosSystem {
        modules = [
          {
            nix.settings.experimental-features = [
              "nix-command"
              "flakes"
            ];
          }
          ./hosts/desktop/configuration.nix
        ];
      };
    };
}