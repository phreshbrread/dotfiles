################
## MAIN FLAKE ##
################

{
  description = "NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11"; # Stable 25.11
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable"; # Unstable

    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest"; # Latest stable release

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nix-flatpak,
      home-manager,
      nixpkgs-unstable,
    }:
    {
      # Macbook
      nixosConfigurations.pheg-nixos-macbook = nixpkgs-unstable.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/macbook/configuration.nix
          ./hosts/macbook/hardware-configuration.nix
          ./nixModules/shared-config.nix

          nix-flatpak.nixosModules.nix-flatpak

          # Make home-manager as a module of nixos so that
          # home-manager configuration will be deployed
          # automatically when executing `nixos-rebuild switch`
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.users.brad = {
              imports = [
                ./nixModules/home.nix
              ];
            };
          }
        ];
      };

      # Desktop
      nixosConfigurations.pheg-nixos-desktop = nixpkgs-unstable.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/desktop/configuration.nix
          ./hosts/desktop/hardware-configuration.nix
          ./hosts/desktop/extra-hardware-configuration.nix
          ./nixModules/shared-config.nix
          ./nixModules/server-stuff.nix

          nix-flatpak.nixosModules.nix-flatpak
        ];
      };

      # Virtual Machine
      nixosConfigurations.nixos-vm = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          # configuration.nix imports hardware config relatively since VM hardware changes often
          ./hosts/virtual-machine/configuration.nix
          ./nixModules/shared-config.nix

          nix-flatpak.nixosModules.nix-flatpak
        ];
      };
    };
}
