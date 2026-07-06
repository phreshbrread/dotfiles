################
## MAIN FLAKE ##
################

{
  description = "NixOS Configuration";

  inputs = {
    nixpkgs.url     = "github:nixos/nixpkgs/nixos-unstable";
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest"; # Latest stable release
    pmenu-tui.url   = "github:PhreshBrread/pmenu";

    nix-index-database = {
      inputs.nixpkgs.follows    = "nixpkgs";
      url                       = "github:nix-community/nix-index-database";
    };
  };

  outputs =
    { self, nixpkgs, nix-flatpak, pmenu-tui, nix-index-database } @inputs: {
      # Desktop
      nixosConfigurations.pheg-nixos-desktop = nixpkgs.lib.nixosSystem {
        system      = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./nixModules/shared-config.nix
          ./hosts/desktop/configuration.nix
          ./hosts/desktop/hardware-configuration.nix
          ./hosts/desktop/extra-hardware-configuration.nix
          ./hosts/desktop/server-stuff.nix

          nix-flatpak.nixosModules.nix-flatpak
          nix-index-database.nixosModules.nix-index
        ];
      };

      # Macbook
      nixosConfigurations.pheg-nixos-macbook = nixpkgs.lib.nixosSystem {
        system      = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./nixModules/shared-config.nix
          ./hosts/macbook/configuration.nix
          ./hosts/macbook/hardware-configuration.nix

          nix-flatpak.nixosModules.nix-flatpak
          nix-index-database.nixosModules.nix-index
        ];
      };

      # Virtual Machine
      nixosConfigurations.nixos-vm = nixpkgs.lib.nixosSystem {
        system      = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./nixModules/shared-config.nix

          # configuration.nix imports hardware config relatively since VM hardware changes often
          ./hosts/virtual-machine/configuration.nix

          nix-flatpak.nixosModules.nix-flatpak
          nix-index-database.nixosModules.nix-index
        ];
      };
    };
}
