##################
## HOME MANAGER ##
##################

{ config, pkgs, ... }:

{
  home = {
    username = "brad";
    homeDirectory = "/home/brad";

    # This value determines the home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new home Manager release introduces backwards
    # incompatible changes.
    #
    # You can update home Manager without changing this value. See
    # the home Manager release notes for a list of state version
    # changes in each release.
    stateVersion = "24.11";
  };

  programs.git = {
    enable = true;
    userName = "PhreshBrread";
    userEmail = "crustydog9@gmail.com";
  };

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
