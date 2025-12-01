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
      excludePackages = with pkgs; [
        xterm
      ];
      displayManager.startx.enable = true;
      windowManager.dwm = {
        enable = true;
        package = pkgs.dwm.overrideAttrs {
          src = ../hosts/macbook/dwm;
        };
      };
      xkb = {
        layout = "au";
        variant = "";
      };
    };

    environment.systemPackages = with pkgs; [
      dmenu
      nitrogen
      copyq
    ];
  };

}
