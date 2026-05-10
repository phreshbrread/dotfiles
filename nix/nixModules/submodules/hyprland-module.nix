#####################
## HYPRLAND MODULE ##
#####################

{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:

let
  hyprqt6engine = pkgs.callPackage "${inputs.hyprqt6engine}/nix/default.nix" {};

  # Symlink fix for NixOS plugin path
  hyprqt6engine-fixed = pkgs.symlinkJoin {
    name = "hyprqt6engine-fixed";
    paths = [ hyprqt6engine ];
    postBuild = ''
      mkdir -p $out/lib/qt-6/plugins/platformthemes
      ln -s ${hyprqt6engine}/lib/qt-6/platformthemes/libhyprqt6engine.so \
            $out/lib/qt-6/plugins/platformthemes/libhyprqt6engine.so
    '';
  };
in
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
      hyprqt6engine-fixed # Pulls from overlay

      # Core
      lxqt.lxqt-notificationd
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
