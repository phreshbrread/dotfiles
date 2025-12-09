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
      # Nano
      nano = {
        enable = true;
        syntaxHighlight = true;
        nanorc = ''
          set nowrap
          set tabstospaces
          set tabsize 2
        '';
      };

      # VSCodium
      vscode = {
        enable = true;
        package = pkgs.vscodium-fhs;
        extensions = with pkgs.vscode-extensions; [
          jnoortheen.nix-ide
          llvm-vs-code-extensions.vscode-clangd
          redhat.vscode-yaml
          tamasfe.even-better-toml
          enkia.tokyo-night
          sumneko.lua
        ];
      };

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

              lualine-nvim
              nvim-highlight-colors

              nvim-treesitter.withAllGrammars
            ];
          };
        };
      };
    };

    # Dependencies
    environment.systemPackages = with pkgs; [
      ripgrep
      fzf
      fd
    ];
  };
}
