####################
## OPENBOX MODULE ##
####################

{
  pkgs,
  lib,
  config,
  ...
}:

{
  options = {
   openbox-module.enable = lib.mkEnableOption "Enables openbox";
  };

  config = lib.mkIf config.openbox-module.enable {
    services.xserver.windowManager.openbox.enable = true;

    environment.systemPackages = with pkgs; [
      obconf
    ];
  };
}
