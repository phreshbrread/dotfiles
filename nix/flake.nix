################
## MAIN FLAKE ##
################

{
  description = "NixOS Configuration";

  inputs = {
    nixpkgs.url        = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-26.05";
    nix-flatpak.url    = "github:gmodena/nix-flatpak/?ref=latest"; # Latest stable release
    pmenu-tui.url      = "github:PhreshBrread/pmenu";
    zooma.url          = "github:PhreshBrread/zooma";

    nix-index-database = {
      inputs.nixpkgs.follows = "nixpkgs";
      url                    = "github:nix-community/nix-index-database";
    };
  };

  outputs = { nixpkgs, ... } @inputs: {
      # Desktop
      nixosConfigurations.pheg-nixos-desktop = nixpkgs.lib.nixosSystem {
        system      = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/desktop
          ./modules
        ];
      };

      # Macbook
      nixosConfigurations.fentbook = nixpkgs.lib.nixosSystem {
        system      = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/macbook
          ./modules
        ];
      };

      # Virtual Machine
      nixosConfigurations.nixos-vm = nixpkgs.lib.nixosSystem {
        system      = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/virtual-machine
          ./modules
        ];
      };
    };
}
