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
      hyprsunset
      hyprtoolkit
      hyprland-qt-support
      hyprland-qtutils

      # Core
      lxqt.lxqt-notificationd
      waypaper
      swaybg
      playerctl
      brightnessctl
      fuzzel
      cliphist
      wl-clipboard
      networkmanagerapplet
      wpa_supplicant_gui

      # Waybar
      waybar
      pavucontrol
      mpd

      # Appearance
      kdePackages.qtstyleplugin-kvantum
      libsForQt5.qtstyleplugin-kvantum
      kdePackages.breeze
      kdePackages.breeze-icons
      tokyonight-gtk-theme
      elementary-xfce-icon-theme
      qt6Packages.qt6ct
      nwg-look
      adwaita-icon-theme

      # Extra
      thunar
    ];
  };
}
