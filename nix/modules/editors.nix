{ pkgs, lib, config, ... }:
let cfg = config.editors; in {
  options.editors.enable = lib.mkEnableOption "Enable text editors";

  config = lib.mkIf cfg.enable {
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
