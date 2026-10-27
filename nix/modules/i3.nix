{ pkgs, lib, config, ... }:
let cfg = config.i3; in {
  options.i3.enable = lib.mkEnableOption "Enable i3wm";

  config = lib.mkIf cfg.enable {
    services.xserver.windowManager.i3 = {
      enable  = true;
      package = pkgs.i3-rounded;
    };

    environment.systemPackages = with pkgs; [
      waypaper
      fsel
    ];
  };
}
