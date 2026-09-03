###################
## REAPER MODULE ##
###################

{
  pkgs,
  lib,
  config,
  ...
}:

{
  options = {
    reaper-module.enable = lib.mkEnableOption "Enables the REAPER DAW";
  };

  config = lib.mkIf config.reaper-module.enable {
    environment.systemPackages = with pkgs; [
      reaper
    ];

    environment.sessionVariables = {
      VST3_PATH = "~/.vst3:/run/current-system/sw/lib/vst3";
      CLAP_PATH = "~/.clap:/run/current-system/sw/lib/clap";
      LV2_PATH  = "~/.lv2:/run/current-system/sw/lib/lv2";
    };
  };
}
