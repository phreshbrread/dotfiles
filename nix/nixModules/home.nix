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
      name = "Materia-dark"; # Replace with your desired theme name
      package = pkgs.materia-theme; # Replace with the corresponding Nix package
    };
    iconTheme = {
      name = "Adwaita"; # Optional: Set an icon theme
      package = pkgs.adwaita-icon-theme; # Optional: Corresponding icon theme package
    };
    cursorTheme = {
      name = "Adwaita"; # Optional: Set a cursor theme
      package = pkgs.adwaita-icon-theme; # Optional: Corresponding cursor theme package
    };
  };

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
