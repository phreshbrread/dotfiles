##########################
## MACBOOK NIXOS CONFIG ##
##########################

{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./packages.nix
  ];

  # Bootloader
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Allow insecure broadcom driver
  nixpkgs.config.permittedInsecurePackages = [
    "broadcom-sta-6.30.223.271-57-6.12.43"
  ];

  # Set hostname
  networking.hostName = "brad-nixos-macbook";

  # Enable NetworkManager
  networking.networkmanager.enable = true;

  # Set time zone
  time.timeZone = "Australia/Melbourne";

  # Select internationalisation properties.
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

  # Environment variables
  environment.variables = {
    GDK_SCALE = "2";
    _JAVA_OPTIONS = "-Dsun.java2d.uiScale=2";
    EDITOR = "nano";
    TERM = "alacritty";
    LIBVA_DRIVER_NAME = "i965";
    QT_QPA_PLATFORM = "wayland";
    GCM_CREDENTIAL_STORE = "secretservice";
  };

  # Define user account
  users.users.brad = {
    isNormalUser = true;
    description = "Brad";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    shell = pkgs.fish;
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

  # Autologin to tty1
  services.getty = {
    autologinUser = "brad";
    autologinOnce = true;
  };

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Intel graphics
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      intel-vaapi-driver
      libvdpau-va-gl
    ];
  };
  hardware.graphics.extraPackages32 = [ pkgs.pkgsi686Linux.intel-vaapi-driver ];

  # Enable Flakes
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Set colour scheme for supported apps
  # This is not for QT/GTK theme
  catppuccin = {
    enable = true;
    flavor = "macchiato";
    accent = "mauve";
  };

  # Qt theming
  qt = {
    enable = true;
    platformTheme = "qt5ct";
    style = "kvantum";
  };

  # Syncthing
  services.syncthing = {
    enable = true;
    user = "brad";
    dataDir = "/home/brad";
  };

  # DWM
  services.xserver = {
    enable = true;
    dpi = 227;
    displayManager.startx.enable = true;
    windowManager.dwm = {
      enable = true;
      package = pkgs.dwm.overrideAttrs {
        src = ./dwm;
      };
    };
    xkb = {
      layout = "au";
      variant = "";
    };
    excludePackages = with pkgs; [
      xterm
    ];
  };

  # XDG desktop portal
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-gtk
    ];
  };

  # Enable programs
  programs.fish.enable = true;
  programs.hyprland.enable = true;
  programs.hyprlock.enable = true;
  programs.kdeconnect.enable = true;
  programs.steam = {
    enable = true;
    protontricks.enable = true;
  };

  # Enable services
  services.openssh.enable = true;
  services.tumbler.enable = true;
  services.gnome.gnome-keyring.enable = true;
  services.power-profiles-daemon.enable = true;

  # Ignore power key
  services.logind.settings.Login.handlePowerKey = "ignore";

  # Disable firewall
  networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
