######################
## MACBOOK PACKAGES ##
######################

{
  pkgs,
  lib,
  config,
  ...
}:

{
  options = {
    macbook-pkgs.enable = lib.mkEnableOption "Enables macbook packages";
  };

  config = lib.mkIf config.macbook-pkgs.enable {
    environment.systemPackages = with pkgs; [
      font-manager
      kdePackages.dolphin
      qbittorrent
      image-roll
      scarlett2 # Focusrite Scarlett driver
    ];
  };
}
