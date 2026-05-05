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
      # Appearance
      kdePackages.qtstyleplugin-kvantum
      libsForQt5.qtstyleplugin-kvantum
      kdePackages.breeze
      kdePackages.breeze-icons
      tokyonight-gtk-theme
      phinger-cursors

      # Extra
      font-manager
      kdePackages.dolphin
      proton-vpn
      qbittorrent
      image-roll
      scarlett2 # Focusrite Scarlett driver
    ];
  };
}
