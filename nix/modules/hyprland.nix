{ pkgs, lib, config, ... }:
let cfg = config.hyprland; in {
  options.hyprland.enable = lib.mkEnableOption "Enable Hyprland WM";

  config = lib.mkIf cfg.enable {
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
      bluetui

      # Waybar
      waybar
      networkmanagerapplet
      pwvucontrol
      mpd

      # Appearance
      kdePackages.qtstyleplugin-kvantum
      libsForQt5.qtstyleplugin-kvantum
      catppuccin-gtk
      elementary-xfce-icon-theme
      qt6Packages.qt6ct
      nwg-look
      adwaita-icon-theme

      # Extra
      thunar
      woomer
    ];
  };
}
