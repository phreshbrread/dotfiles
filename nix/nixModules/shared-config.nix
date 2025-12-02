###################
## SHARED CONFIG ##
###################

{ config, pkgs, ... }:

{
  # Import all modules here
  # Hosts can simply toggle the ones needed
  imports = [
    ./submodules/dwm-module.nix
    ./submodules/hyprland-module.nix
    ./submodules/pkg/pkg-module.nix
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable NetworkManager
  networking.networkmanager.enable = true;

  # Enable Flakes
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Environment variables
  environment.variables = {
    GCM_CREDENTIAL_STORE = "secretservice";
    TERMINAL = "alacritty";
    EDITOR = "nvim";
  };

  # Use doas instead of sudo
  # User must be in 'wheel' group
  security = {
    sudo.enable = false;
    doas = {
      enable = true;
      wheelNeedsPassword = true;
      extraRules = [
        {
          groups = [ "wheel" ];
          keepEnv = true;
          persist = true;
        }
      ];
    };
  };

  # Enable realtime daemon
  security.rtkit.enable = true;

  # Enable XDG portals
  xdg.portal.enable = true;

  # Declare services
  services = {
    # Enable Flatpak
    flatpak = {
      enable = true;
      update.auto = {
        enable = true;
        onCalendar = "weekly";
      };
    };

    # Enable printing
    printing = {
      enable = true;
      drivers = with pkgs; [
        # Canon print drivers
        gutenprint
        gutenprintBin
        cnijfilter2
      ];
    };

    # Configure keymap in X11
    xserver.xkb = {
      layout = "au";
      variant = "";
    };

    # Enable sound with pipewire
    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
  };

  # Enable firewall
  networking.firewall = {
    enable = true;
    allowPing = true;
    logRefusedConnections = true;
  };

  # Programs
  programs = {
    git.enable = true;
    tmux.enable = true;
    fish = {
      enable = true;
      shellAliases = {
        x = "exit";
        ls = "eza -alg --group-directories-first --icons=always";
        cls = "clear";
        sudo = "doas";
        tmux-mc = "tmux a -t minecraft-server";
        sudoedit = "doas rnano";
        install-date = "stat / | grep Birth";
        tmux-terraria = "tmux a -t terraria-server";
      };
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

    # Enable AppImage
    appimage = {
      enable = true;
      binfmt = true;
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
  };

  # Time zone + locale
  time.timeZone = "Australia/Melbourne";
  i18n.defaultLocale = "en_AU.UTF-8";
  i18n.extraLocales = [ "all" ];
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_AU.UTF-8";
    LC_IDENTIFICATION = "en_AU.UTF-8";
    LC_MEASUREMENT = "en_AU.UTF-8";
    LC_MONETARY = "en_AU.UTF-8";
    LC_NAME = "en_AU.UTF-8";
    LC_NUMERIC = "en_AU.UTF-8";
    LC_PAPER = "en_AU.UTF-8";
    LC_TELEPHONE = "en_AU.UTF-8";
    LC_TIME = "en_AU.UTF-8";
  };
}
