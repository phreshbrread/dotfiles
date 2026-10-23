######################
## SYNCTHING MODULE ##
######################

{
  pkgs,
  lib,
  config,
  ...
}:

{
  options = {
    syncthing-module.enable = lib.mkEnableOption "Enables Syncthing";
  };

  config = lib.mkIf config.syncthing-module.enable {
    services.syncthing = {
      enable = true;
      user = "brad";
      dataDir = "/home/brad";
    };
  };
}
