################
## MAIN FLAKE ##
################

{
  description = "NixOS Configuration";

  inputs = {
    nixpkgs.url     = "github:nixos/nixpkgs/nixos-26.05";
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest"; # Latest stable release
    pmenu-tui.url   = "github:PhreshBrread/pmenu";
    zooma.url       = "github:PhreshBrread/zooma";

    nix-index-database = {
      inputs.nixpkgs.follows = "nixpkgs";
      url                    = "github:nix-community/nix-index-database";
    };
  };

  outputs =
    { self, nixpkgs, nix-flatpak, pmenu-tui, zooma, nix-index-database } @inputs: {
      # Desktop
      nixosConfigurations.pheg-nixos-desktop = nixpkgs.lib.nixosSystem {
        system      = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/desktop
          ./modules

          nix-flatpak.nixosModules.nix-flatpak
          nix-index-database.nixosModules.nix-index
        ];
      };

      # Macbook
      nixosConfigurations.fentbook = nixpkgs.lib.nixosSystem {
        system      = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/macbook
          ./modules

          nix-flatpak.nixosModules.nix-flatpak
          nix-index-database.nixosModules.nix-index
        ];
      };

      # Virtual Machine
      nixosConfigurations.nixos-vm = nixpkgs.lib.nixosSystem {
        system      = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/virtual-machine
          ./modules

          nix-flatpak.nixosModules.nix-flatpak
          nix-index-database.nixosModules.nix-index
        ];
      };
    };
}
