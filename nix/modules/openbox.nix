{ pkgs, lib, config, ... }:
let cfg = config.openbox; in {
  options.openbox.enable = lib.mkEnableOption "Enable openbox";

  config = lib.mkIf cfg.enable {
    services.xserver.windowManager.openbox.enable = true;
    environment.systemPackages = [ pkgs.obconf ];
  };
}
