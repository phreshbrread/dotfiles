####################
## EDITORS MODULE ##
####################

{
  pkgs,
  lib,
  config,
  ...
}:

{
  options = {
    editors-module.enable = lib.mkEnableOption "Enables text editors";
  };

  config = lib.mkIf config.editors-module.enable {
    programs = {
      # Neovim
      neovim = {
        enable = true;
        viAlias = true;
        vimAlias = true;
        configure = {
          customRC = ''
            source ~/dotfiles/config/nvim/init.lua
          '';
        };
      };
    };

    environment.systemPackages = with pkgs; [
      # Neovim Dependencies
      ripgrep
      fzf
      fd
      luarocks
      lua5_1
      tree-sitter
    ];
  };
}
