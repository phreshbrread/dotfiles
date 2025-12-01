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
      hyprpolkitagent
      hyprprop
      hyprnotify
      hyprcursor
      swaynotificationcenter
      waybar
      waypaper
      swaybg
      networkmanagerapplet
      mpd
      playerctl
      brightnessctl
      fuzzel
      xfce.thunar
      smile
      hyprshot
      clipse
      nemo-with-extensions
    ];
  };
}
