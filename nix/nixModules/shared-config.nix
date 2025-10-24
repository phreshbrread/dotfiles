###################
## SHARED CONFIG ##
###################

{ config, pkgs, ... }:

{
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable NetworkManager
  networking.networkmanager.enable = true;

  # Enable Flakes
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Enable realtime daemon
  security.rtkit.enable = true;

  # Enable XDG portals
  xdg.portal.enable = true;

  # Declare services
  services = {
    # Enable Flatpak
    flatpak.enable = true;

    # Enable CUPS for printing
    printing.enable = true;

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

  # Shared programs
  programs = {
    git.enable = true;
    fish.enable = true;

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
        '';
      };
    };
  };

  # Time zone + locale
  time.timeZone = "Australia/Melbourne";
  i18n.defaultLocale = "en_AU.UTF-8";
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
