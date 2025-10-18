##########################
## DESKTOP NIXOS CONFIG ##
##########################

{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./extra-hardware-configuration.nix
    ./../../nixModules/locale.nix
    ./../../nixModules/server-specific.nix
    ./../../nixModules/desktop-packages.nix
  ];

  # Bootloader
  boot.loader = {
    efi.canTouchEfiVariables = true;
    systemd-boot = {
      enable = true;
      configurationLimit = 5;
      memtest86.enable = true;
    };
  };

  # Use latest kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Garbage collection
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  # Environment variables
  environment.variables = {
    NIXPKGS_ALLOW_UNFREE = "1";
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
  services = {
    displayManager.sddm.enable = true;
    desktopManager.plasma6.enable = true;
    displayManager.autoLogin.user = "brad";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "au";
    variant = "";
  };

  # Enable sound with pipewire
  security.rtkit.enable = true;
  services = {
    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
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
      "audio"
    ];
  };

  # Use doas instead of sudo
  security = {
    sudo.enable = false;
    doas = {
      enable = true;
      extraRules = [
        {
          users = [ "brad" ];
          keepEnv = true;
          persist = true;
        }
      ];
    };
  };

  # Enable programs
  programs = {
    git.enable = true;
    fish.enable = true;
    gamemode.enable = true;
    kdeconnect.enable = true;

    # OBS + Plugins
    obs-studio = {
      enable = true;
      plugins = [ pkgs.obs-studio-plugins.droidcam-obs ];
    };

    # Steam
    steam = {
      enable = true;
      protontricks.enable = true;
      gamescopeSession.enable = true;
    };

    # Thunderbird
    thunderbird = {
      enable = true;
      package = pkgs.thunderbird-latest;
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

    # Enable AppImage
    appimage = {
      enable = true;
      binfmt = true;
    };
  };

  # Realtime permissions
  security.pam.loginLimits = [
    {
      domain = "@audio";
      item = "rtprio";
      type = "-";
      value = "95";
    }
    {
      domain = "@audio";
      item = "memlock";
      type = "-";
      value = "unlimited";
    }
  ];

  # Enable VM support
  programs.virt-manager.enable = true;
  users.groups.libvirtd.members = [ "brad" ];
  virtualisation = {
    libvirtd.enable = true;
    spiceUSBRedirection.enable = true;
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
