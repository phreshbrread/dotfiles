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
  ];

  # Enable macbook packages module
  macbook-pkgs.enable = true;

  # Enable WM modules
  hyprland-module.enable = true;
  dwm-module.enable = true;

  # Set hostname
  networking.hostName = "pheg-nixos-macbook";

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
    TERMINAL = "alacritty";
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

  # Syncthing
  services.syncthing = {
    enable = true;
    user = "brad";
    dataDir = "/home/brad";
  };

  # Use ly
  services.displayManager.ly.enable = true;

  # Enable AwesomeWM
  services.xserver.windowManager.awesome.enable = true;

  # Enable touchpad
  services.libinput = {
    enable = true;
    touchpad = {
      accelProfile = "flat"; # Disable touchpad acceleration
      naturalScrolling = true;
      disableWhileTyping = true;
    };
  };

  # Declare flatpaks
  services.flatpak.packages = [
    "org.polymc.PolyMC"
    "fr.handbrake.ghb"
    "fm.reaper.Reaper"
    "org.jdownloader.JDownloader"
  ];

  # Enable programs
  programs = {
    kdeconnect.enable = true;
    steam = {
      enable = true;
      protontricks.enable = true;
    };
  };

  # Enable services
  services = {
    openssh.enable = true;
    tumbler.enable = true;
    gnome.gnome-keyring.enable = true;
    power-profiles-daemon.enable = true;
  };

  # Ignore power key
  services.logind.settings.Login = {
    HandlePowerKey = "ignore";
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
