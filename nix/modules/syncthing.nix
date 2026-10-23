{ pkgs, lib, config, ... }:
let cfg = config.syncthing; in {
  options.syncthing.enable = lib.mkEnableOption "Enable Syncthing";

  config = lib.mkIf cfg.enable {
    services.syncthing = {
      enable = true;
      user = "brad";
      dataDir = "/home/brad";
    };
  };
}
