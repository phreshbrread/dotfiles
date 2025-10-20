################
## MAIN FLAKE ##
################

{
  description = "NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05"; # Stable 25.05
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest"; # Latest stable release

    catppuccin.url = "github:catppuccin/nix";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs, nix-flatpak, ... }@inputs:
    {
      # Macbook
      nixosConfigurations.brad-nixos-macbook = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          inputs.nixosModules.catppuccin
          inputs.nixosModules.nix-flatpak

          ./hosts/macbook/configuration.nix

          # make home-manager as a module of nixos
          # so that home-manager configuration will be deployed automatically when executing `nixos-rebuild switch`
          inputs.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.users.brad = {
              imports = [
                ./nixModules/home.nix
                inputs.homeModules.catppuccin
              ];
            };
          }
        ];
      };

      # Desktop
      nixosConfigurations.pheg-nixos-desktop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          nix-flatpak.nixosModules.nix-flatpak
          ./hosts/desktop/configuration.nix
        ];
      };

      # Virtual Machine
      nixosConfigurations.nixos-vm = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/virtual-machine/configuration.nix
        ];
      };
    };
}
