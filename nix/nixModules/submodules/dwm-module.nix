################
## DWM MODULE ##
################

{
  pkgs,
  lib,
  config,
  ...
}:

{
  options = {
    dwm-module.enable = lib.mkEnableOption "Enables DWM";
  };

  config = lib.mkIf config.dwm-module.enable {
    services.xserver = {
      enable = true;
      dpi = 227;
      autoRepeatDelay = 200;
      autoRepeatInterval = 35;
      excludePackages = with pkgs; [
        xterm
      ];
      windowManager.dwm = {
        enable = true;
        package = pkgs.dwm.overrideAttrs {
          src = ../../dwm;
        };
      }; 
    };

    environment.systemPackages = with pkgs; [
      dmenu
      nitrogen
      copyq
      picom
    ];
  };
}
