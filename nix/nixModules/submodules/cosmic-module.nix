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
  };
}
