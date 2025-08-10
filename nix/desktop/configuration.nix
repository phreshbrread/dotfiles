##########################
## DESKTOP NIXOS CONFIG ##
##########################

{ config, pkgs, ... }:

{
  imports = [
    ./locale.nix
    ./packages.nix
    ./server-specific.nix
    ./hardware-configuration.nix
    ./extra-hardware-configuration.nix
  ];

  # Bootloader
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  # Use latest kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Environment variables
  environment.variables = {
    GCM_CREDENTIAL_STORE = "secretservice";
  };

  # Enable Flakes
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Set hostname
  networking.hostName = "pheg-nixos-desktop";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable NetworkManager
  networking.networkmanager.enable = true;

  # Enable KDE Plasma
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;
  services.displayManager.autoLogin.user = "brad";

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "au";
    variant = "";
  };

  # Enable sound with pipewire
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Enable Flatpak
  services.flatpak.enable = true;

  # OpenRGB udev rules
  services = {
    udev.packages = with pkgs; [
      openrgb-with-all-plugins
    ];
  };

  # Syncthing
  services.syncthing = {
    enable = true;
    user = "brad";
    dataDir = "/home/brad";
  };

  # Enable CUPS for printing
  services.printing.enable = true;

  # Define user account
  users.users.brad = {
    isNormalUser = true;
    description = "Brad";
    shell = pkgs.fish;
    extraGroups = [
      "networkmanager"
      "wheel"
      "video"
      "render"
    ];
  };

  # Use doas instead of sudo
  security.doas.enable = true;
  security.sudo.enable = false;
  security.doas.extraRules = [
    {
      users = [ "brad" ];
      keepEnv = true;
      persist = true;
    }
  ];

  # Enable AppImages
  programs.appimage = {
    enable = true;
    binfmt = true;
  };

  # Enable programs
  programs.git.enable = true;
  programs.fish.enable = true;
  programs.gamemode.enable = true;
  programs.kdeconnect.enable = true;
  programs.steam = {
    enable = true;
    protontricks.enable = true;
    gamescopeSession.enable = true;
  };
  programs.thunderbird = {
    enable = true;
    package = pkgs.thunderbird-latest;
  };
  programs.nano = {
    enable = true;
    syntaxHighlight = true;
    nanorc = ''
      set nowrap
      set tabstospaces
      set tabsize 2
    '';
  };

  # Neovim
  programs.neovim = {
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

  # Enable firewall
  networking.firewall = {
    enable = true;
    allowPing = true;
    logRefusedConnections = true;
  };

  # Initial system state version (no need to change)
  system.stateVersion = "25.05";
}
