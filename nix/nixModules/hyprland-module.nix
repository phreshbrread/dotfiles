#####################
## HYPRLAND MODULE ##
#####################

{
  pkgs,
  lib,
  config,
  ...
}:

{
  options = {
    hyprland-module.enable = lib.mkEnableOption "Enables Hyprland";
  };

  config = lib.mkIf config.hyprland-module.enable {
    programs = {
      hyprland.enable = true;
      hyprlock.enable = true;
    };

    # Specify XDG desktop portals
    xdg.portal = {
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
        xdg-desktop-portal-hyprland
      ];
    };
  };
}
