######################
## DESKTOP PACKAGES ##
######################

{
  pkgs,
  lib,
  config,
  ...
}:

{
  options = {
    desktop-pkgs.enable = lib.mkEnableOption "Enables desktop packages";
  };

  config = lib.mkIf config.desktop-pkgs.enable {
    environment.systemPackages = with pkgs; [
      # Core
      i2c-tools
      wget
      yad

      # Extra
      floorp-bin
      brave
      pcsx2
      dolphin-emu
      kdePackages.kdenlive
      protonup-qt
      heroic
      lutris
      umu-launcher
      gimp3-with-plugins
      yabridge
      yabridgectl
      winetricks
      onlyoffice-desktopeditors
      equibop
      arrpc
      mangareader
      azahar
      OVMF
      jdk
      jdk8
    ];
  };
}
