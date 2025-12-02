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
            filetype on
            syntax on
            set number
            set expandtab
            set tabstop=3
            set shiftwidth=3
            set autoindent
            set smartindent 
            set cursorcolumn
            set relativenumber
            nnoremap <C-p> :FuzzyOpen<CR>
          '';
          packages.myVimPackage = with pkgs.vimPlugins; {
            start = [
              nvim-treesitter.withAllGrammars
              nvim-cmp
              neovim-fuzzy
            ];
          };
        };
      };

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
        ];
      };
    };
  };
}
