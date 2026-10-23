###################
## COSMIC MODULE ##
###################

{
  pkgs,
  lib,
  config,
  ...
}:

{
  options = {
   cosmic-module.enable = lib.mkEnableOption "Enables cosmic";
  };

  config = lib.mkIf config.cosmic-module.enable {
    services.desktopManager.cosmic = {
        enable = true;
        xwayland.enable = true;
    };

    environment.cosmic.excludePackages = with pkgs; [
        cosmic-store
        cosmic-reader
        cosmic-term
        cosmic-edit
        cosmic-player
    ];
  };
}
