##############################
## X WINDOW MANAGERS MODULE ##
##############################

{
  pkgs,
  lib,
  config,
  ...
}:

{
  options = {
    x-module.enable = lib.mkEnableOption "Enables X Window Managers";
  };

  config = lib.mkIf config.x-module.enable {

    services.xserver = {
      enable = true;
      dpi = 227;
      autoRepeatDelay = 200;
      autoRepeatInterval = 35;
      excludePackages = with pkgs; [
        xterm
      ];
      windowManager = {
        awesome.enable = true; # Enable AwesomeWM
        dwm = {
          # Enable custom DWM package
          enable = true;
          package = pkgs.dwm.overrideAttrs {
            src = ../../dwm;
          };
        };
      };
    };

    environment.systemPackages = with pkgs; [
      dmenu
      nitrogen
      copyq
      picom
      rofi
    ];
  };
}
