{ pkgs, lib, config, ... }:
let cfg = config.systemdBoot; in {
  options.systemdBoot.enable = lib.mkEnableOption "Enable systemd-boot";

  config = lib.mkIf cfg.enable {
    boot.loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot = {
        enable = true;
        configurationLimit = 5;
        memtest86.enable = true;
      };
    };
  };
}
