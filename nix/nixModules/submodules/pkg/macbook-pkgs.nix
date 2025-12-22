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

      # Appearance
      kdePackages.qtstyleplugin-kvantum
      libsForQt5.qtstyleplugin-kvantum
      arc-theme
      papirus-icon-theme
      phinger-cursors

      # Extra
      floorp-bin
      hyprpicker
      font-manager
      kdePackages.dolphin
      kdePackages.gwenview
      protonvpn-gui
      qbittorrent
      kdePackages.falkon
    ];
  };
}
