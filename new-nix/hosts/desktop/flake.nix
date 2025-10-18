#################
## BASIC FLAKE ##
#################

{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
  };

  outputs = inputs: {
    nixosConfigurations.pheg-nixos-desktop = inputs.nixpkgs.lib.nixosSystem {
      modules = [
        {
          nix.settings.experimental-features = [
            "nix-command"
            "flakes"
          ];
        }
        ./configuration.nix
      ];
    };
  };
}
