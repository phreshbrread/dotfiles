##########################
## MACBOOK NIXOS CONFIG ##
##########################

{
  config,
  pkgs,
  lib,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ./../../nixModules/shared-config.nix
    ./../../nixModules/pkg/macbook-packages.nix
  ];

  # Set hostname
  networking.hostName = "brad-nixos-macbook";

  # Set kernel packages
  boot.kernelPackages = pkgs.linuxPackages;

  # Bootloader
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  # Allow insecure broadcom driver
  nixpkgs.config = {
    allowInsecurePredicate = pkg: builtins.elem (lib.getName pkg) [ "broadcom-sta" ];
  };

  # Environment variables
  environment.variables = {
    GDK_SCALE = "2";
    _JAVA_OPTIONS = "-Dsun.java2d.uiScale=2";
    EDITOR = "nano";
    TERM = "alacritty";
    LIBVA_DRIVER_NAME = "i965";
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
    #style = "kvantum";
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
    excludePackages = with pkgs; [
      xterm
    ];
    displayManager.startx.enable = true;
    windowManager.dwm = {
      enable = true;
      package = pkgs.dwm.overrideAttrs {
        src = ./dwm;
      };
    };
    windowManager.awesome.enable = true;
    xkb = {
      layout = "au";
      variant = "";
    };
  };

  services.libinput = {
    enable = true;
    # Disable touchpad acceleration
    touchpad = {
      accelProfile = "flat";
      naturalScrolling = true;
      disableWhileTyping = true;
    };
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
  programs.git.enable = true;
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
  #services.logind.settings.Login.HandlePowerKey = "ignore";
  services.logind.extraConfig = ''HandlePowerKey=ignore'';

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
