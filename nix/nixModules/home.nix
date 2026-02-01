##################
## HOME MANAGER ##
##################

{ config, pkgs, ... }:

{
  home = {
    username = "brad";
    homeDirectory = "/home/brad";
    stateVersion = "24.11"; # No need to change, only signifies minimum version to avoid breakage
  };

  # Set gtk theme
  gtk = {
    enable = true;
    theme = {
      name = "Tokyonight-Dark";
      package = pkgs.tokyonight-gtk-theme;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    cursorTheme = {
      name = "phinger-cursors-dark";
      package = pkgs.phinger-cursors;
    };
  };

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
