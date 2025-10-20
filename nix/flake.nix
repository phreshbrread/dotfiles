################
## MAIN FLAKE ##
################

{
  description = "NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest"; # Latest stable release

    catppuccin.url = "github:catppuccin/nix";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      nixpkgs,
      catppuccin,
      nix-flatpak,
      home-manager,
      ...
    }:
    {
      # Macbook
      nixosConfigurations.brad-nixos-macbook = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          catppuccin.nixosModules.catppuccin
          nix-flatpak.nixosModules.nix-flatpak

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

      # Desktop
      nixosConfigurations.pheg-nixos-desktop = inputs.nixpkgs.lib.nixosSystem {
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

      # Virtual Machine
      nixosConfigurations.nixos-vm = inputs.nixpkgs.lib.nixosSystem {
        modules = [
          {
            nix.settings.experimental-features = [
              "nix-command"
              "flakes"
            ];
          }
          ./hosts/virtual-machine/configuration.nix
        ];
      };
    };
}
