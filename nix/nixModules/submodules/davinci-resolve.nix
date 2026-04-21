############################
## DAVINCI RESOLVE MODULE ##
############################

{
  pkgs,
  lib,
  config,
  ...
}:

{
  options = {
    davinci-resolve.enable = lib.mkEnableOption "Enables Davinci Resolve";
  };

  config = lib.mkIf config.davinci-resolve.enable {
    # Fix missing GPU in settings
    hardware.graphics.extraPackages = with pkgs; [ rocmPackages.clr.icd ];

    environment.systemPackages = with pkgs; [
      davinci-resolve
    ];
  };
}
