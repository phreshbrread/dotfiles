################
## MAIN FLAKE ##
################

{
  description = "NixOS Configuration";

  inputs = {
    nixpkgs.url         = "github:nixos/nixpkgs/nixos-unstable";        # Unstable
    nixpkgs-stable.url  = "github:nixos/nixpkgs/nixos-25.11";           # Stable 25.11
    nix-flatpak.url     = "github:gmodena/nix-flatpak/?ref=latest";     # Latest stable release
    pmenu-git.url       = "github:PhreshBrread/pmenu/dev";              # pmenu dev branch

    nix-index-database = {
      inputs.nixpkgs.follows    = "nixpkgs";
      url                       = "github:nix-community/nix-index-database";
    };
  };

  outputs =
    { self, nixpkgs, nixpkgs-stable, nix-flatpak, pmenu-git, nix-index-database } @inputs: {
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
