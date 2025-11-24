######################
## MACBOOK PACKAGES ##
######################

{
  pkgs,
  lib,
  config,
  ...
}:

{
  options = {
    macbook-pkgs.enable = lib.mkEnableOption "Enables macbook packages";
  };

  config = lib.mkIf config.macbook-pkgs.enable {
    environment.systemPackages = with pkgs; [
      # System
      pavucontrol
      slint-lsp
      shfmt

      # DWM
      dmenu
      nitrogen
      copyq

      # Hyprland
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

      # Appearance
      kdePackages.qtstyleplugin-kvantum
      libsForQt5.qtstyleplugin-kvantum
      arc-theme
      papirus-icon-theme
      phinger-cursors

      # Extra
      wev
      hyprpicker
      floorp
      font-manager
      kdePackages.dolphin
      kdePackages.gwenview
      space-cadet-pinball
    ];
  };
}
