###################
## GAMING MODULE ##
###################

{
  pkgs,
  lib,
  config,
  ...
}:

{
  options = {
    gaming-module.enable = lib.mkEnableOption "Enables Steam + other gaming stuff";
  };

  config = lib.mkIf config.gaming-module.enable {
    programs.steam = {
      enable = true;
      protontricks.enable = true;
      extraCompatPackages = with pkgs; [
        proton-ge-bin
        steamtinkerlaunch
      ];
      package = pkgs.steam.override {
        extraPkgs =
          pkgs': with pkgs'; [
            xorg.libXcursor
            xorg.libXi
            xorg.libXinerama
            xorg.libXScrnSaver
            libpng
            libpulseaudio
            libvorbis
            stdenv.cc.cc.lib # Provides libstdc++.so.6
            libkrb5
            keyutils
          ];
      };
    };
  };
}
