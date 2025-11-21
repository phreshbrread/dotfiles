##################
## SYSTEM FONTS ##
##################

{ pkgs, ... }:

{
  fonts.enableDefaultPackages = true;
  fonts.packages = with pkgs; [
    corefonts
    font-awesome
    nerd-fonts.hack
    noto-fonts
  ];
}
