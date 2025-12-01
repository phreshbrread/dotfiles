{
  pkgs,
  lib,
  config,
  ...
}:

{
  options = {
    template-module.enable = lib.mkEnableOption "Enables [...]";
  };

  config = lib.mkIf config.template-module.enable {

  };
}
