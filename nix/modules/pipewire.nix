{ pkgs, lib, config, ... }:
let cfg = config.pipewire; in {
  options.pipewire.enable = lib.mkEnableOption "Enable sound with pipewire";

  config = lib.mkIf cfg.enable {
    services = {
      pulseaudio.enable = false;
      pipewire = {
        enable            = true;
        alsa.enable       = true;
        alsa.support32Bit = true;
        pulse.enable      = true;
        jack.enable       = true;
      };
    };
  };
}
