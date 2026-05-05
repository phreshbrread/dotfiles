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

  # Enable Hyprland + Hyprlock
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

    # Hyprland packages
    environment.systemPackages = with pkgs; [
      # Hypr
      hyprpolkitagent
      hyprprop
      hyprnotify
      hyprcursor
      hyprpicker
      hyprshot

      # Core
      swaynotificationcenter
      waypaper
      swaybg
      playerctl
      brightnessctl
      fuzzel
      cliphist
      wl-clipboard

      # Waybar
      waybar
      networkmanagerapplet
      pavucontrol
      mpd

      # Extra
      thunar
    ];
  };
}
