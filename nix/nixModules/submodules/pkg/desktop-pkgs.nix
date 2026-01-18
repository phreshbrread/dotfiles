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
      brave
      pcsx2
      floorp-bin
      dolphin-emu
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
      scrcpy
      blanket
      kdePackages.kdenlive
      android-tools
      shadps4
    ];
  };
}
