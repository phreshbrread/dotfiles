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

    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      catppuccin,
      nix-flatpak,
      home-manager,
      rust-overlay,
    }:
    {
      # Macbook
      nixosConfigurations.brad-nixos-macbook = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/macbook/configuration.nix

          catppuccin.nixosModules.catppuccin
          nix-flatpak.nixosModules.nix-flatpak

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

          # Rust overlay
          (
            { pkgs, ... }:
            {
              nixpkgs.overlays = [ rust-overlay.overlays.default ];
              environment.systemPackages = [ pkgs.rust-bin.stable.latest.default ];
            }
          )
        ];
      };

      # Desktop
      nixosConfigurations.pheg-nixos-desktop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/desktop/configuration.nix

          nix-flatpak.nixosModules.nix-flatpak
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
