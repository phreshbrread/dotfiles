{ pkgs, lib, config, ... }:
let cfg = config.cosmic; in {
  options.cosmic.enable = lib.mkEnableOption "Enable cosmic desktop";

  config = lib.mkIf cfg.enable {
    services.desktopManager.cosmic = {
        enable = true;
        xwayland.enable = true;
    };

    environment.cosmic.excludePackages = with pkgs; [
        cosmic-store
        cosmic-reader
        cosmic-term
        cosmic-edit
        cosmic-player
    ];
  };
}
