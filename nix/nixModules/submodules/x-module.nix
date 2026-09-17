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
      enable             = true;
      autoRepeatDelay    = 200;
      autoRepeatInterval = 35;
      excludePackages    = [ pkgs.xterm ];
      windowManager = {
        awesome.enable = true;
        i3 = {
          enable  = true;
          package = pkgs.i3-rounded;
        };
      };
    };

    services.xserver.displayManager.importedVariables = [
      "GDK_SCALE" "GDK_DPI_SCALE" "QT_AUTO_SCREEN_SCALE_FACTOR" "JAVA_TOOL_OPTIONS"
    ];

    environment.systemPackages = with pkgs; [
      waypaper
      feh
      copyq
      picom
      rofi
      xrdb
    ];
  };
}
