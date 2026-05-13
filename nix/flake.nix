################
## MAIN FLAKE ##
################

{
  description = "NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11"; # Stable 25.11
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable"; # Unstable

    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest"; # Latest stable release

    pmenu-git.url = "github:PhreshBrread/pmenu/dev"; # pmenu dev branch
  };

  outputs =
    {
      self,
      nixpkgs,
      nix-flatpak,
      pmenu-git,
      nixpkgs-unstable,
    }@inputs:
    {
      # Macbook
      nixosConfigurations.pheg-nixos-macbook = nixpkgs-unstable.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/macbook/configuration.nix
          ./hosts/macbook/hardware-configuration.nix
          ./nixModules/shared-config.nix

          nix-flatpak.nixosModules.nix-flatpak
        ];
      };

      # Desktop
      nixosConfigurations.pheg-nixos-desktop = nixpkgs-unstable.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/desktop/configuration.nix
          ./hosts/desktop/hardware-configuration.nix
          ./hosts/desktop/extra-hardware-configuration.nix
          ./hosts/desktop/server-stuff.nix
          ./nixModules/shared-config.nix

          nix-flatpak.nixosModules.nix-flatpak
        ];
      };

      # Virtual Machine
      nixosConfigurations.nixos-vm = nixpkgs-unstable.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          # configuration.nix imports hardware config relatively since VM hardware changes often
          ./hosts/virtual-machine/configuration.nix
          ./nixModules/shared-config.nix

          nix-flatpak.nixosModules.nix-flatpak
        ];
      };
    };
}
