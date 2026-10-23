#########################
## SYSTEMD-BOOT MODULE ##
#########################

{
  pkgs,
  lib,
  config,
  ...
}:

{
  options = {
    systemd-boot-module.enable = lib.mkEnableOption "Enables systemd-boot";
  };

  config = lib.mkIf config.systemd-boot-module.enable {
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
