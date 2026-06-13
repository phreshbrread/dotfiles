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
    hardware.xpadneo.enable = true;

    programs.gamemode = {
      enable        = true;
      enableRenice  = true;
    };
    programs.steam = {
      enable                = true;
      protontricks.enable   = true;
      extraCompatPackages = with pkgs; [
        proton-ge-bin
        steamtinkerlaunch
      ];
      package = pkgs.steam.override {
        extraLibraries = pkgs: with pkgs; [
          libX11
          libxcb
          libXcursor
          libXi
          libXinerama
          libXext
          libXrandr
          libXrender
          libXScrnSaver
          libpng
          libpulseaudio
          libvorbis
          stdenv.cc.cc.lib
          libkrb5
          keyutils
        ];
        extraPkgs = pkgs': with pkgs'; [
          adwaita-icon-theme
        ];
      };
    };
  };
}
