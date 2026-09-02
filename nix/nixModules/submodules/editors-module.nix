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
          packages.myVimPackage = with pkgs.vimPlugins; {
            start = [
              tokyonight-nvim
              nvim-cmp
              nvim-web-devicons

              telescope-nvim
              plenary-nvim
              telescope-fzf-native-nvim
              vim-better-whitespace
              nvim-autopairs
              nvim-lspconfig
              nvim-treesitter.withAllGrammars
              presence-nvim
              render-markdown-nvim
              trouble-nvim

              lualine-nvim
              nvim-highlight-colors
            ];
          };
        };
      };
    };

    environment.systemPackages = with pkgs; [
      # Neovim Dependencies
      ripgrep
      fzf
      fd
      clang-tools # For nvim LSP
      tree-sitter
    ];
  };
}
