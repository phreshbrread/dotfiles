{ pkgs, lib, config, ... }:
let cfg = config.xorg; in {
  options.xorg.enable = lib.mkEnableOption "Enable common X settings";

  config = lib.mkIf cfg.enable {
    services.xserver = {
      enable             = true;
      autoRepeatDelay    = 200;
      autoRepeatInterval = 35;
      excludePackages    = [ pkgs.xterm ];
    };

    services.xserver.displayManager.importedVariables = [
      "GDK_SCALE" "GDK_DPI_SCALE" "QT_AUTO_SCREEN_SCALE_FACTOR" "JAVA_TOOL_OPTIONS"
    ];

    environment.systemPackages = with pkgs; [
      xinit
      xwallpaper
    ];
  };
}
