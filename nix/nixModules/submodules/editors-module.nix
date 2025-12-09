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
            filetype plugin indent on
            syntax on

            nnoremap <C-p> :Telescope find_files<CR>

            colorscheme tokyonight

            source ~/dotfiles/config/nvim/init.lua

            hi Normal guibg=NONE ctermbg=NONE
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
