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

            set number
            set relativenumber
            set expandtab
            set shiftwidth=4
            set tabstop=4
            set softtabstop=4
            set smartindent 
            set cursorcolumn

            nnoremap <C-p> :Telescope find_files<CR>

            colorscheme tokyonight

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
