{ pkgs, lib, config, ... }:
let cfg = config.gaming; in {
  options.gaming.enable = lib.mkEnableOption "Enable Steam + other gaming-related stuff";

  config = lib.mkIf cfg.enable {
    hardware.xpadneo.enable = true;

    programs.gamemode = {
      enable        = true;
      enableRenice  = true;
    };
    hardware.steam-hardware.enable = true;
    programs.steam = {
      enable                = true;
      protontricks.enable   = true;
      extraCompatPackages = with pkgs; [
        #proton-ge-bin
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

    environment.variables = {
      #PROTON_PREFER_SDL = "1";
    };
  };
}
